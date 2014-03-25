using System;
using System.Data.SqlClient;
using System.Data;
using System.Xml;
using System.Collections;
using System.Configuration;

namespace BLCompliance
{
    public class CData
    {
        /// <summary>
        /// Static Connection string variable
        /// </summary>
        public static readonly string mstrConnString = System.Configuration.ConfigurationSettings.AppSettings["dbconn"];

		 //static int  cmdTimeout = int.Parse(System.Configuration.ConfigurationSettings.AppSettings["cmdtimeout"].ToString());

		static int cmdTimeout = 3600;

        #region "Custom Routines & Functions"

        #region "parameter Attaching"
        /// <summary>
        /// This method is used to attach array of SqlParameters to a SqlCommand.
        /// This method will assign a value of DbNull to any parameter with a direction of
        /// InputOutput and a value of null.  
        /// 
        /// This behavior will prevent default values from being used, but
        /// this will be the less common case than an intended pure output parameter (derived as InputOutput)
        /// where the user provided no input value.
        /// 
        /// </summary>
        /// <param name="command">The command to which the parameters will be added</param>
        /// <param name="commandParameters">an array of SqlParameters tho be added to command</param>
        private static void AttachParameters(SqlCommand command, SqlParameter[] commandParameters)
        {
            foreach (SqlParameter p in commandParameters)
            {
                //check for derived output value with no value assigned
                if ((p.Direction == ParameterDirection.InputOutput) && (p.Value == null))
                {
                    p.Value = DBNull.Value;
                }

                command.Parameters.Add(p);
            }
        }
        #endregion

        #region "Assigning Parameter Values"
        /// <summary>
        /// This method assigns an array of values to an array of SqlParameters.
        /// </summary>
        /// <param name="commandParameters">array of SqlParameters to be assigned values</param>
        /// <param name="parameterValues">array of objects holding the values to be assigned</param>
        private static void AssignParameterValues(SqlParameter[] commandParameters, object[] parameterValues)
        {
            if ((commandParameters == null) || (parameterValues == null))
            {
                //do nothing if we get no data
                return;
            }
            // we must have the same number of values as we have parameters to put them in
            if (commandParameters.Length != parameterValues.Length)
            {
                throw new ArgumentException("Parameter count does not match Parameter Value count.");
            }
            //iterate through the SqlParameters, assigning the values from the corresponding position in the 
            //value array
            for (int i = 0, j = commandParameters.Length; i < j; i++)
            {
                commandParameters[i].Value = parameterValues[i];
            }
        }
        #endregion

        #region "Prepare Command overloaded"
        /// <summary>
        /// This method opens (if necessary) 
        /// and assigns a connection, transaction, command type and parameters 
        /// to the provided command.
        /// </summary>
        /// <param name="command">the SqlCommand to be prepared</param>
        /// <param name="connection">a valid SqlConnection, on which to execute this command</param>
        /// <param name="transaction">a valid SqlTransaction, or 'null'</param>
        /// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
        /// <param name="commandText">the stored procedure name or T-SQL command</param>
        /// <param name="commandParameters">an array of SqlParameters to be associated with the command or 'null' if no parameters are required</param>
        private static void PrepareCommand(SqlCommand command, SqlConnection connection, SqlTransaction transaction, CommandType commandType, string commandText, SqlParameter[] commandParameters)
        {
            //if the provided connection is not open, we will open it
            if (connection.State != ConnectionState.Open)
            {
                connection.Open();
            }

            //associate the connection with the command
            command.Connection = connection;

            //set the command text (stored procedure name or SQL statement)
            command.CommandText = commandText;

            //if we were provided a transaction, assign it.
            if (transaction != null)
            {
                command.Transaction = transaction;
            }

            //set the command type
            command.CommandType = commandType;

            //attach the command parameters if they are provided
            if (commandParameters != null)
            {
                AttachParameters(command, commandParameters);
            }

            return;
        }

        #endregion

        #region "Execute Non Query (returns int)"
        /// <summary>
        /// Execute a SqlCommand (that returns no resultset) against the database 
        /// specified in the connection string 
        /// using the provided parameters.
        /// <code>
        /// int result = ExecuteNonQuery(connString, CommandType.StoredProcedure, "PublishOrders", new SqlParameter("@prodid", 24));
        /// </code>		
        /// </summary>				
        /// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
        /// <param name="commandText">the stored procedure name or T-SQL command</param>
        /// <param name="commandParameters">an array of SqlParamters used to execute the command</param>
        /// <returns>returns an int representing the number of rows affected by the command</returns>
        public static int ExecuteNonQuery(CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //Generating Command text for debugging.

            //			string strTxt = commandText ;
            //
            //			for(int i=0;i<commandParameters.Length;i++)
            //				strTxt += commandParameters[i].ParameterName + " = '" + commandParameters[i].Value + "', ";
            //
            //			strTxt = strTxt.Substring(0,strTxt.Length-1);


            //create & open a SqlConnection, and dispose of it after we are done.
            using (SqlConnection cn = new SqlConnection(mstrConnString))
            {
                cn.Open();

                //call the overload that takes a connection in place of the connection string
                return ExecuteNonQuery(cn, commandType, commandText, commandParameters);
            }
        }


        public static int ExecuteNonQuery(string commandText, out Hashtable outparamm, CommandType commandType, params SqlParameter[] parameters)
        {
            using (SqlConnection cn = new SqlConnection(mstrConnString))
            {
                try
                {
                    cn.Open();
                    SqlCommand cmd = new SqlCommand();
                    //return ExecuteNonQuery(cn, commandType, commandText, parameters);
                    PrepareCommand(cmd, cn, (SqlTransaction)null, commandType, commandText, parameters);

                    outparamm = new Hashtable();

                    int norowsAffected = cmd.ExecuteNonQuery();
                    if (parameters != null)
                    {
                        foreach (SqlParameter sqlParam in parameters)
                        {
                            if (sqlParam.Direction == ParameterDirection.Output)
                                outparamm.Add(sqlParam.ParameterName, cmd.Parameters[sqlParam.ParameterName].Value.ToString());
                        }
                    }
                    cmd.Parameters.Clear();
                    return norowsAffected;
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }
        #endregion

        #region "Execute Non Query (overloaded) "
        /// <summary>
        /// Execute a stored procedure via a SqlCommand (that returns no resultset) against the database specified in 
        /// the connection string using the provided parameter values.  This method will query the database to discover the parameters for the 
        /// stored procedure (the first time each stored procedure is called), and assign the values based on parameter order.
        /// This method provides no access to output parameters or the stored procedure's return value parameter.
        /// <code>int result = ExecuteNonQuery(connString, "PublishOrders", 24, 36);</code>		
        /// </summary>		
        /// <param name="spName">the name of the stored prcedure</param>
        /// <param name="parameterValues">an array of objects to be assigned as the input values of the stored procedure</param>
        /// <returns>returns an int representing the number of rows affected by the command</returns>
        public static int ExecuteNonQuery(string spName, params object[] parameterValues)
        {
            //if we receive parameter values, we need to figure out where they go
            if ((parameterValues != null) && (parameterValues.Length > 0))
            {
                //pull the parameters for this stored procedure from the parameter cache (or discover them & populate the cache)
                SqlParameter[] commandParameters = SqlHelperParameterCache.GetSpParameterSet(spName);

                //assign the provided values to these parameters based on parameter order
                AssignParameterValues(commandParameters, parameterValues);

                //call the overload that takes an array of SqlParameters
                return ExecuteNonQuery(CommandType.StoredProcedure, spName, commandParameters);
            }
            //otherwise we can just call the SP without params
            else
            {
                return ExecuteNonQuery(CommandType.StoredProcedure, spName);
            }
        }
        #endregion

        #region "Exeute Non Query (Overloaded )"
        /// <summary>
        /// Execute a SqlCommand (that returns no resultset) against the specified SqlConnection 
        /// using the provided parameters.		
        /// <code>int result = ExecuteNonQuery(conn, CommandType.StoredProcedure, "PublishOrders", new SqlParameter("@prodid", 24));</code>
        /// </summary>
        /// <param name="connection">a valid SqlConnection </param>
        /// <param name="commandType">the CommandType (stored procedure, text, etc.) </param>
        /// <param name="commandText">the stored procedure name or T-SQL command </param>
        /// <param name="commandParameters">an array of SqlParamters used to execute the command </param>
        /// <returns>returns an int representing the number of rows affected by the command</returns>
        public static int ExecuteNonQuery(SqlConnection connection, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //create a command and prepare it for execution
            SqlCommand cmd = new SqlCommand();
            PrepareCommand(cmd, connection, (SqlTransaction)null, commandType, commandText, commandParameters);

            //finally, execute the command.
            int retval = cmd.ExecuteNonQuery();

            // detach the SqlParameters from the command object, so they can be used again.
            cmd.Parameters.Clear();
            return retval;
        }
        #endregion


        #region "Execute Non Query (Overloaded )" 
        /// <summary>
        /// Execute a SqlCommand (that returns no resultset) against the specified SqlConnection 
        /// using the provided parameters.		
        /// <code>int result = ExecuteNonQuery(Trans, CommandType.StoredProcedure, "PublishOrders", new SqlParameter("@prodid", 24));</code>
        /// </summary>
        /// <param name="Transaction">a valid SqlConnection </param>
        /// <param name="commandType">the CommandType (stored procedure, text, etc.) </param>
        /// <param name="commandText">the stored procedure name or T-SQL command </param>
        /// <param name="commandParameters">an array of SqlParamters used to execute the command </param>
        /// <returns>returns an int representing the number of rows affected by the command</returns>
        public static int ExecuteNonQuery(SqlTransaction Transaction, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //create a command and prepare it for execution
            SqlCommand cmd = new SqlCommand();
            PrepareCommand(cmd, Transaction.Connection, Transaction, commandType, commandText, commandParameters);

            //finally, execute the command.
            int retval = cmd.ExecuteNonQuery();

            // detach the SqlParameters from the command object, so they can be used again.
            cmd.Parameters.Clear();
            return retval;
        }
        #endregion

        #region "Executing A Dataset from a SQL Statement"
        /// <summary>
        /// Execute a SqlCommand (that returns a resultset) against the 
        /// database specified in the connection string 
        /// using the provided parameters.
        /// <code>DataSet ds = ExecuteDataset(connString, CommandType.StoredProcedure, "GetOrders", new SqlParameter("@prodid", 24));</code>
        /// </summary>		
        /// <param name="commandType">the CommandType (stored procedure, text, etc.) </param>
        /// <param name="commandText">the stored procedure name or T-SQL command </param>
        /// <param name="commandParameters">an array of SqlParamters used to execute the command </param>
        /// <returns>returns a dataset containing the resultset generated by the command</returns>
        public static DataSet ExecuteDataset(CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //create & open a SqlConnection, and dispose of it after we are done.
            using (SqlConnection cn = new SqlConnection(mstrConnString))
            {
                cn.Open();

                //call the overload that takes a connection in place of the connection string
                return ExecuteDataset(cn, commandType, commandText, commandParameters);
            }
        }
        #endregion

        #region "Executing a dataset against a SQL Query"
        /// <summary>
        /// Execute a SqlCommand (that returns a resultset) against the specified SqlConnection 
        /// using the provided parameters.
        /// <code>DataSet ds = ExecuteDataset(conn, CommandType.StoredProcedure, "GetOrders", new SqlParameter("@prodid", 24));</code>
        /// </summary>
        /// <param name="connection">a valid SqlConnection</param>
        /// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
        /// <param name="commandText">the stored procedure name or T-SQL command</param>
        /// <param name="commandParameters">an array of SqlParamters used to execute the command</param>
        /// <returns>returns a dataset containing the resultset generated by the command</returns>
        public static DataSet ExecuteDataset(SqlConnection connection, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //create a command and prepare it for execution
            SqlCommand cmd = new SqlCommand();
			
			// The time in seconds to wait for the command to execute. The default is 30 seconds.
			cmd.CommandTimeout = cmdTimeout;
            PrepareCommand(cmd, connection, (SqlTransaction)null, commandType, commandText, commandParameters);

            //create the DataAdapter & DataSet
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();

            //fill the DataSet using default values for DataTable names, etc.
            da.Fill(ds);

            // detach the SqlParameters from the command object, so they can be used again.			
            cmd.Parameters.Clear();

            //return the dataset
            return ds;
        }
        #endregion

        #region "Executing a dataset against a SQL Query with Transaction"
        /// <summary>
        /// Execute a SqlCommand (that returns a resultset) against the specified SqlConnection 
        /// using the provided parameters.
        /// <code>DataSet ds = ExecuteDataset(Trans, CommandType.StoredProcedure, "GetOrders", new SqlParameter("@prodid", 24));</code>
        /// </summary>
        /// <param name="transaction">a valid SqlTransaction</param>
        /// <param name="commandType">the CommandType (stored procedure, text, etc.)</param>
        /// <param name="commandText">the stored procedure name or T-SQL command</param>
        /// <param name="commandParameters">an array of SqlParamters used to execute the command</param>
        /// <returns>returns a dataset containing the resultset generated by the command</returns>
        public static DataSet ExecuteDataset(SqlTransaction transaction, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //create a command and prepare it for execution
            SqlCommand cmd = new SqlCommand();
            cmd.CommandTimeout = cmdTimeout;
            PrepareCommand(cmd, transaction.Connection, transaction, commandType, commandText, commandParameters);

            //create the DataAdapter & DataSet
            SqlDataAdapter da = new SqlDataAdapter(cmd);

            DataSet ds = new DataSet();

            //fill the DataSet using default values for DataTable names, etc.
            da.Fill(ds);

            // detach the SqlParameters from the command object, so they can be used again.			
            cmd.Parameters.Clear();

            //return the dataset
            return ds;
        }
        #endregion

        #region "Getting a single Result from a SQL Query (ExecuteScalar)"
        /// <summary>
        /// Execute a SqlCommand (that returns a 1x1 resultset) against the database specified in the connection string 
        /// using the provided parameters.
        /// <code>int orderCount = (int)ExecuteScalar(connString, CommandType.StoredProcedure, "GetOrderCount", new SqlParameter("@prodid", 24));</code>
        /// </summary>		
        /// <param name="commandType">the CommandType (stored procedure, text, etc.) </param>
        /// <param name="commandText">the stored procedure name or T-SQL command </param>
        /// <param name="commandParameters">an array of SqlParamters used to execute the command </param>
        /// <returns>returns an object containing the value in the 1x1 resultset generated by the command</returns>
        public static object ExecuteScalar(CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //create & open a SqlConnection, and dispose of it after we are done.
            using (SqlConnection cn = new SqlConnection(mstrConnString))
            {
                cn.Open();

                //call the overload that takes a connection in place of the connection string
                return ExecuteScalar(cn, commandType, commandText, commandParameters);
            }
        }
        #endregion

        #region "Getting a single value againt a SQL Query"
        /// <summary>
        /// Execute a stored procedure via a SqlCommand (that returns a 1x1 resultset) against the database specified in 
        /// the connection string using the provided parameter values.  This method will query the database to discover the parameters for the 
        /// stored procedure (the first time each stored procedure is called), and assign the values based on parameter order. 
        /// This method provides no access to output parameters or the stored procedure's return value parameter.
        /// <code>int orderCount = (int)ExecuteScalar(connString, "GetOrderCount", 24, 36);</code>
        /// </summary>		
        /// <param name="spName">the name of the stored procedure</param>
        /// <param name="parameterValues">an array of objects to be assigned as the input values of the stored procedure </param>
        /// <returns>returns an object containing the value in the 1x1 resultset generated by the command</returns>
        public static object ExecuteScalar(string spName, params object[] parameterValues)
        {
            //if we receive parameter values, we need to figure out where they go
            if ((parameterValues != null) && (parameterValues.Length > 0))
            {
                //pull the parameters for this stored procedure from the parameter cache (or discover them & populate the cache)
                SqlParameter[] commandParameters = SqlHelperParameterCache.GetSpParameterSet(spName);

                //assign the provided values to these parameters based on parameter order
                AssignParameterValues(commandParameters, parameterValues);

                //call the overload that takes an array of SqlParameters
                return ExecuteScalar(CommandType.StoredProcedure, spName, commandParameters);
            }
            //otherwise we can just call the SP without params
            else
            {
                return ExecuteScalar(CommandType.StoredProcedure, spName);
            }
        }
        #endregion

        #region "Executing a SQL Command and returning a single value"
        /// <summary>
        /// Execute a SqlCommand (that returns a 1x1 resultset) against the specified SqlConnection 
        /// using the provided parameters.
        /// <code>int orderCount = (int)ExecuteScalar(conn, CommandType.StoredProcedure, "GetOrderCount", new SqlParameter("@prodid", 24));</code> 
        /// </summary>
        /// <param name="connection">a valid SqlConnection </param>
        /// <param name="commandType">the CommandType (stored procedure, text, etc.) </param>
        /// <param name="commandText">the stored procedure name or T-SQL command </param>
        /// <param name="commandParameters">an array of SqlParamters used to execute the command </param>
        /// <returns>returns an object containing the value in the 1x1 resultset generated by the command</returns>
        public static object ExecuteScalar(SqlConnection connection, CommandType commandType, string commandText, params SqlParameter[] commandParameters)
        {
            //create a command and prepare it for execution
            SqlCommand cmd = new SqlCommand();
            PrepareCommand(cmd, connection, (SqlTransaction)null, commandType, commandText, commandParameters);
            //execute the command & return the results
            object retval = cmd.ExecuteScalar();
            // detach the SqlParameters from the command object, so they can be used again.
            cmd.Parameters.Clear();
            return retval;
        }

        #endregion

        #region "-Getting DataTable from SqlQuery"

        private DataTable GetDataTable(SqlCommand ObjSqlCmd)
        {
            ObjSqlCmd.Connection.Open();
            SqlDataAdapter objSqladp = new SqlDataAdapter(ObjSqlCmd);
            try
            {
                DataSet objresDS = new DataSet();
                objSqladp.Fill(objresDS);
                return objresDS.Tables[0];
            }
            finally
            {
                ObjSqlCmd.Connection.Close();
            }
        }

        #endregion


        #region "Get Connection Object"
        ///<summary>
        ///Get connection object that returns SqlConnection Object in Open State
        ///<param name="conString"> a volid Sql server Connection string for Connection
        ///<returns> returns an object containing Connection object in Open State
        public static SqlConnection GetConnection(string conString)
        {
            SqlConnection objConnection = new SqlConnection(conString);
            objConnection.Open();
            return objConnection;
        }
        #endregion

        #region "Get Connection Object"						
        ///<summary>
        ///Get connection object that returns SqlConnection Object in Open State
        ///<returns> returns an object containing Connection object in Open State
        public static SqlConnection GetConnection()
        {
            SqlConnection objConnection = new SqlConnection(mstrConnString);
            objConnection.Open();
            return objConnection;
        }

        #endregion

        #region "Executing a SQL Command and returning a single value"
        /// <summary>
        /// Execute a SqlCommand (that returns a 1x1 resultset) against the specified SqlConnection 
        /// using the provided parameters.
        /// <code>int orderCount = (int)ExecuteScalar(conn, CommandType.StoredProcedure, "GetOrderCount", new SqlParameter("@prodid", 24));</code> 
        /// </summary>
        /// <param name="Command">a valid SqlCommand</param>
        /// <param name="commandParameters">an array of SqlParamters used to execute the command </param>
        /// <returns>returns an object containing the value in the 1x1 resultset generated by the command</returns>
        public static int ExecuteNonQuery(SqlCommand command, params SqlParameter[] commandParameters)
        {
            //assign command Type
            command.CommandType = CommandType.StoredProcedure;
            //attach parameters to Command 
            AttachParameters(command, commandParameters);
            //execute the command & return the results
            int retval = command.ExecuteNonQuery();
            // detach the SqlParameters from the command object, so they can be used again.
            command.Parameters.Clear();
            return retval;
        }

        #endregion

        #region "Executing a SQL Command and returning a single value"
        /// <summary>
        /// Execute a SqlCommand (that returns a 1x1 resultset) against the specified SqlConnection 
        /// using the provided parameters.
        /// <code>int orderCount = (int)ExecuteScalar(conn, CommandType.StoredProcedure, "GetOrderCount", new SqlParameter("@prodid", 24));</code> 
        /// </summary>
        /// <param name="command">a valid SqlConnection </param>
        /// <param name="commandParameters">an array of SqlParamters used to execute the command </param>
        /// <returns>returns an object containing the value in the 1x1 resultset generated by the command</returns>
        public static object ExecuteScalar(SqlCommand command, params SqlParameter[] commandParameters)
        {
            //--Attach Parameters-------------------
            AttachParameters(command, commandParameters);
            //execute the command & return the results
            object retval = command.ExecuteScalar();
            // detach the SqlParameters from the command object, so they can be used again.
            command.Parameters.Clear();
            return retval;
        }

        #endregion

        #region "Executing A Dataset from a SQL Statement"
        /// <summary>
        /// Execute a SqlCommand (that returns a resultset) against the 
        /// database specified in the connection string 
        /// using the provided parameters.
        /// <code>DataSet ds = ExecuteDataset(connString, CommandType.StoredProcedure, "GetOrders", new SqlParameter("@prodid", 24));</code>
        /// </summary>		
        /// <param name="command"> valid SqlCommandetc.) </param>
        /// <param name="commandParameters">an array of SqlParamters used to execute the command </param>
        /// <returns>returns a dataset containing the resultset generated by the command</returns>
        public static DataTable ExecuteDataset(SqlCommand command, params SqlParameter[] commandParameters)
        {
            //Attach Parameter
            AttachParameters(command, commandParameters);
            //SqlDataAddapter 
            SqlDataAdapter sqldtAdapter = new SqlDataAdapter(command);
            //DataTabel
            DataTable dtTable = new DataTable();
            sqldtAdapter.Fill(dtTable);
            command.Parameters.Clear();
            return dtTable;
        }
        #endregion


        //---------------------------------------------------------------------
        //---------------------------------------------------------------------
        #endregion
    }


    #region "Class SqlHelperParameterCache"
    /// <summary>
    /// SqlHelperParameterCache provides functions to leverage a static cache of procedure parameters, and the
    /// ability to discover parameters for stored procedures at run-time.
    /// </summary>
    public sealed class SqlHelperParameterCache
    {
        /// <summary>
        /// Conenction String For DB Access (!!!)
        /// </summary>
        //public static readonly string mstrConnString=System.Configuration.ConfigurationSettings.AppSettings["ConnString"];
        public static readonly string mstrConnString = System.Configuration.ConfigurationSettings.AppSettings["dbconn"];

        #region "Constructors and members"
        /// <summary>
        /// Since this class provides only static methods, make the default constructor 
        /// private to prevent  
        /// instances from being created with "new SqlHelperParameterCache()".
        /// </summary>
        private SqlHelperParameterCache() { }

        /// <summary>
        /// Cache object for managing parameters
        /// </summary>
        private static Hashtable paramCache = Hashtable.Synchronized(new Hashtable());
        #endregion

        #region "Getting SQL Parameterset"
        /// <summary>
        /// resolve at run time the appropriate set of SqlParameters for a stored procedure
        /// </summary>		
        /// <param name="spName">the name of the stored procedure </param>
        /// <param name="includeReturnValueParameter">whether or not to include their return value parameter </param>
        /// <returns>Array of SQL Parameters</returns>
        private static SqlParameter[] DiscoverSpParameterSet(string spName, bool includeReturnValueParameter)
        {
            using (SqlConnection cn = new SqlConnection(mstrConnString))
            using (SqlCommand cmd = new SqlCommand(spName, cn))
            {
                cn.Open();
                cmd.CommandType = CommandType.StoredProcedure;

                SqlCommandBuilder.DeriveParameters(cmd);

                if (!includeReturnValueParameter)
                {
                    cmd.Parameters.RemoveAt(0);
                }

                SqlParameter[] discoveredParameters = new SqlParameter[cmd.Parameters.Count]; ;

                cmd.Parameters.CopyTo(discoveredParameters, 0);

                return discoveredParameters;
            }
        }
        #endregion

        #region "Cloning parameters"
        /// <summary>
        /// Cloning parameters (Coping parameters into new parameter sets)
        /// </summary>
        /// <param name="originalParameters">Array of SQL parameters</param>
        /// <returns>Array of SQL parameters</returns>
        private static SqlParameter[] CloneParameters(SqlParameter[] originalParameters)
        {
            //deep copy of cached SqlParameter array
            SqlParameter[] clonedParameters = new SqlParameter[originalParameters.Length];

            for (int i = 0, j = originalParameters.Length; i < j; i++)
            {
                clonedParameters[i] = (SqlParameter)((ICloneable)originalParameters[i]).Clone();
            }
            return clonedParameters;
        }
        #endregion

        #region "Add Parameter to cache"
        /// <summary>
        ///	add parameter array to the cache
        /// </summary>		
        /// <param name="commandText">the stored procedure name or T-SQL command </param>
        /// <param name="commandParameters">an array of SqlParamters to be cached </param>
        public static void CacheParameterSet(string commandText, params SqlParameter[] commandParameters)
        {
            string hashKey = mstrConnString + ":" + commandText;

            paramCache[hashKey] = commandParameters;
        }
        #endregion

        #region "Extract Array of SP Parameters from Cache"
        /// <summary>
        /// Retrieve a parameter array from the cache 
        /// </summary>		
        /// <param name="commandText">the stored procedure name or T-SQL command </param>
        /// <returns>returns an array of SqlParamters</returns>
        public static SqlParameter[] GetCachedParameterSet(string commandText)
        {
            string hashKey = mstrConnString + ":" + commandText;

            SqlParameter[] cachedParameters = (SqlParameter[])paramCache[hashKey];

            if (cachedParameters == null)
            {
                return null;
            }
            else
            {
                return CloneParameters(cachedParameters);
            }
        }
        #endregion

        #region "Get Stored Proc Parameter Set as an Array"
        /// <summary>
        /// Retrieves the set of SqlParameters appropriate for the stored procedure 
        /// This method will query the database for this information, and then store it in a cache for future requests.
        /// </summary>		
        /// <param name="spName">the name of the stored procedure </param>
        /// <returns>returns an array of SqlParameters</returns>
        public static SqlParameter[] GetSpParameterSet(string spName)
        {
            return GetSpParameterSet(spName, false);
        }
        #endregion

        #region "Get SQL parameterset as a SQL Parameter Array"
        /// <summary>
        /// Retrieves the set of SqlParameters appropriate for the stored procedure 
        /// This method will query the database for this information, and then store it in a cache for future requests.
        /// </summary>		
        /// <param name="spName">the name of the stored procedure </param>
        /// <param name="includeReturnValueParameter">a bool value indicating whether the return value parameter should be included in the results </param>
        /// <returns>returns an array of SqlParameters</returns>
        public static SqlParameter[] GetSpParameterSet(string spName, bool includeReturnValueParameter)
        {
            string hashKey = mstrConnString + ":" + spName + (includeReturnValueParameter ? ":include ReturnValue Parameter" : "");

            SqlParameter[] cachedParameters;

            cachedParameters = (SqlParameter[])paramCache[hashKey];

            if (cachedParameters == null)
            {
                cachedParameters = (SqlParameter[])(paramCache[hashKey] = DiscoverSpParameterSet(spName, includeReturnValueParameter));
            }

            return CloneParameters(cachedParameters);
        }
        #endregion

    }
    #endregion
}