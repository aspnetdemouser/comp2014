using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace BLCompliance
{
    public class Result
    {
        /// <summary>
        /// true or false
        /// </summary>
        public bool ResultStatus { get; set; }

        /// <summary>
        /// 1 success,
        /// > 500 (not valid inputs or any required field is empty)
        /// > 1000 ( not found or any error)
        /// </summary>
        public int ResultCode { get; set; }
        public string ResultMessage { get; set; }

        public Result()
        {
            this.ResultStatus = false;
            this.ResultCode = 0;
            this.ResultMessage = "";

        }
        public Result(int resultCode, bool resultStatus,string message)
        {
            this.ResultStatus = resultStatus;
            this.ResultCode = resultCode;
            this.ResultMessage = message;

        }

    }
}
