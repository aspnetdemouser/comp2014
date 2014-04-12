
/**************************** Validate SSN *****************************************/

function TValidateSSN(oControl, bSkipIfBlank) {
    if ((oControl.value == "") && (bSkipIfBlank == true))
        return true;
    else {
        var strWarning = "The SSN must be in the following format ###-##-####.";

        if (!oControl.value.match(/^\d{3}-\d{2}-\d{4}$/) && !oControl.value.match("___-__-____")) {
            WarningBox(strWarning);
            oControl.focus();
            oControl.select();
            return false;
        }
        true;
    }
}


function formatSSN(objValue) {
    var theCount = 0;
    var theString = objValue;
    var newString = "";
    var myString = theString;
    var theLen = myString.length;
    for (var i = 0; i < theLen; i++) {
        // Character codes for ints 1 - 9 are 48 - 57
        if ((myString.charCodeAt(i) >= 48) && (myString.charCodeAt(i) <= 57))
            newString = newString + myString.charAt(i);
    }
    // Now the validation to determine that the remaining string is 9 characters.
    if (newString.length == 9) {
        // Now the string has been stripped of other chars it can be reformatted to ###-##-#### 
        var newLen = newString.length;
        var newSSN = "";
        for (var i = 0; i < newLen; i++) {
            if ((i == 2) || (i == 4)) {
                newSSN = newSSN + newString.charAt(i) + "-";
            } else {
                newSSN = newSSN + newString.charAt(i);
            }
        }
        return newSSN;
    }
    else {
        return objValue;
    }
}

/* ********************   NEW VALIDATION SCRIPT STARTS HERE ************************************ */

function strSetControlValidationProperty(strControlId, strControlType, tIsRequired, strValidationFormat, tIsSpaceAllow, tIsSpecialCharAllow) {
    return strControlId + "," + strControlType + "," + tIsRequired + "," + strValidationFormat + "," + tIsSpaceAllow + "," + tIsSpecialCharAllow;
}

function getInnerText(obj) {
    return obj.textContent ? obj.textContent : obj.innerText
}


/* Function to set the */
function setInnerText(elementId, text) {

    var element;

    if (document.getElementById) {
        element = document.getElementById(elementId);

    }

    else if (document.all) {
        element = document.all[elementId];
    }
    if (element) {

        if (typeof element.textContent != 'undefined') {
            element.textContent = text;
        }

        else if (typeof element.innerText != 'undefined') {
            element.innerText = text;
        }
        else if (typeof element.value != 'undefined') {
            element.value = text;
        }

        else if (typeof element.removeChild != 'undefined') {

            while (element.hasChildNodes()) {
                element.removeChild(element.lastChild);
            }

            element.appendChild(document.createTextNode(text));
        }
    }
}







function TValidateControls(arrControlCollections) {

    var tResult = false;
    if (arrControlCollections.length > 0) {

        for (var i = 0; i < arrControlCollections.length; i++) {

            if (arrControlCollections[i] != "") {
                var arrControl = arrControlCollections[i].toString().split(",");

                if (arrControl[2] == "true")//required
                {
                    var arrReqFields = new Array(arrControl[0]);
                    tResult = TValidateRequiredField(arrReqFields)
                    if (!tResult) return tResult;
                }
                tResult = TValidateFormat(arrControl[0], arrControl[1], arrControl[2], arrControl[3], arrControl[4], arrControl[5]);

                if (!tResult) return tResult;
            }
        }
    }

    ClearTopStatus();
    return true;
}

function TValidateRequiredField(arrFieldIDs) {

    if (arrFieldIDs.length > 0) {
        for (var i = 0; i < arrFieldIDs.length; i++) {
            if (document.getElementById(arrFieldIDs[i])) {
                if (trim(document.getElementById(arrFieldIDs[i]).value) == "")//|| document.getElementById(arrFieldIDs[i]).value == "-1"
                {
                    WarningBox('Fields marked as * are required');
                    document.getElementById(arrFieldIDs[i]).focus();
                    return false;
                }
            }
        }
    }
    return true;
}


function TValidateFormat(strObjectId, strObjectType, tIsRequired, strValidationFormat, tIsSpaceAllow, tIsSpecialCharAllow) {

    var strChars = "";
    var strAlertMsg = "";
    var tResult = false;
    var tValidChars = true;

    if (strValidationFormat.toLowerCase() == "alpha") {
        tValidChars = true;
        strChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz., ";
        strAlertMsg = "Only letters are allowed!";
    }
    else if (strValidationFormat.toLowerCase() == "numeric") {
        tValidChars = true;
        strChars = "1234567890";
        strAlertMsg = "Only numbers are allowed!";
    }
    else if (strValidationFormat.toLowerCase() == "alphanumeric") {
        tValidChars = true;
        strChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890., ";
        strAlertMsg = "Only alphanumeric values are allowed!";
    }
    else if (strValidationFormat.toLowerCase() == "phone")//need to improove: allow ()-+ 
    {
        tValidChars = true;
        strChars = "1234567890-() ";
        strAlertMsg = "Only phone format is allowed!";
    }
    else if (strValidationFormat.toLowerCase() == "int") {
        tResult = IsInt(document.getElementById(strObjectId));
        return tResult;
    }
    else if (strValidationFormat.toLowerCase() == "float") {
        tResult = IsFloat(document.getElementById(strObjectId));
        return tResult;
    }
    else if (strValidationFormat.toLowerCase() == "filename") {
        tValidChars = false;
        strChars = '\/:*?"<>|';
        strAlertMsg = "Characters: \/:*?\"<>| are not allowed!";
    }
    else if (strValidationFormat.toLowerCase() == "email") {

        if (document.getElementById(strObjectId)) {
            if (document.getElementById(strObjectId).value.length > 0) {
                var sEmail = document.getElementById(strObjectId).value;
                sEmail = trim(sEmail);
                var atsym = sEmail.indexOf("@");
                var period = sEmail.lastIndexOf('.');
                var space = sEmail.indexOf(' ');
                var length = sEmail.length - 1;

                if ((atsym < 1) || (period <= atsym + 1) || (period == length) || (space != -1)) {
                    WarningBox('Invalid email id!');
                    document.getElementById(strObjectId).focus();
                    return false;
                }
            }
        }
        return true;
    }
    else if (strValidationFormat.toLowerCase() == "date") {
        tValidChars = true;
        strChars = "1234567890/";
        strAlertMsg = "Invalid date!";
        tResult = tCheckValidCharcters(strObjectId, strChars, tValidChars, strAlertMsg);
        if (!tResult) return tResult;

        tResult = tIsDate(strObjectId);
        if (!tResult) { document.getElementById(strObjectId).focus(); return false; }
        return true;
    }
    else if (strValidationFormat.toLowerCase() == "blocksinglequote") {
        tValidChars = false;
        strChars = "'";
        if (tIsSpaceAllow.toLowerCase() == "false")
            strChars += " ";
        strAlertMsg = "Invalid format: Please remove single quote!";
    }
    else if (strValidationFormat.toLowerCase() == "url") {
        tResult = isURL(document.getElementById(strObjectId).value);
        if (!tResult) { document.getElementById(strObjectId).focus(); return false; }
        else { return true; }
    }
    else if (strValidationFormat.toLowerCase() == "urlstring") {
        tValidChars = false;
        strChars = "#";
        strAlertMsg = "Invalid format: Please remove #!";
    }
    else if (strValidationFormat.toLowerCase() == "urlstringandblocksinglequote") {
        tValidChars = false;
        strChars = "#'";
        strAlertMsg = "Invalid format: Please remove # and single quote!";
    }
    else {
        return true;
    }

    if (strValidationFormat.toLowerCase() != "blocksinglequote" && strValidationFormat.toLowerCase() != "filename" && strValidationFormat.toLowerCase() != "url") {
        if (tIsSpaceAllow.toLowerCase() == "true") {
            strChars = strChars + " ";
        }
        if (tIsSpecialCharAllow.toLowerCase() == "true") {
            strChars = strChars + "`-=[]\;',./~!@#$%^&*()_+{}|:\"<>?";
        }
    }

    tResult = tCheckValidCharcters(strObjectId, strChars, tValidChars, strAlertMsg);
    if (!tResult) return tResult;

    return true;

}


function tCheckValidCharcters(strObjectId, strChars, tValidChars, strAlertMsg) {

    if (document.getElementById(strObjectId)) {
        var strObjectValue = trim(document.getElementById(strObjectId).value);
        if (tValidChars) {
            for (var i = 0; i < strObjectValue.length; i++) {
                if (strChars.indexOf(strObjectValue.charAt(i)) == "-1") {
                    WarningBox(strAlertMsg + "(" + strObjectValue + ")");
                    if (document.getElementById(strObjectId)) document.getElementById(strObjectId).focus();
                    return false;
                }
            }
        }
        else {
            for (var i = 0; i < strObjectValue.length; i++) {
                if (strChars.indexOf(strObjectValue.charAt(i)) != "-1") {
                    WarningBox(strAlertMsg);
                    if (document.getElementById(strObjectId)) document.getElementById(strObjectId).focus();
                    return false;
                }
            }
        }
    }
    return true;
}

function IsFloat(e) {
    var sText = document.getElementById(e.id).value;


    var ValidChars = "0123456789.";
    var InValidChars = "_`-!@#$%^&*()+=[]\\\;,/{}|\:<>? ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'''";
    var IsNumber = true;
    var Char;
    var key;
    if (window.event) {
        key = window.event.keyCode;
    }
    else if (e) {
        key = e.which;
    }
    else {
        return true;
    }

    if (key == 8 || key == 37 || key == 39 || key == 46)
        return true;

    var iNumericVal = "";
    for (i = 0; i < sText.length; i++) {
        Char = sText.charAt(i);
        if (Char == "-" && i == 0) {
            iNumericVal += Char;
        }
        if (InValidChars.indexOf(Char) == -1) {
            iNumericVal += Char;
        }

    }


    document.getElementById(e.id).value = "";

    if (iNumericVal.indexOf(".") > -1)
        iNumericVal = iNumericVal.substring(0, iNumericVal.indexOf(".") + 3);

    var straDecimal = iNumericVal.split(".");
    if (straDecimal.length > 2) iNumericVal = 0;

    if (iNumericVal == "") iNumericVal = 0;
    if (iNumericVal == "0") iNumericVal = "0.00";
    document.getElementById(e.id).value = iNumericVal;

    //document.getElementById(e.id).focus();
    return IsNumber;

}

function IsInt(e) {
    var sText = document.getElementById(e.id).value;
    var ValidChars = "0123456789";
    var InValidChars = "._`-!@#$%^&*()+=[]\\\;,/{}|\:<>? ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'''";
    var IsNumber = true;
    var Char;
    var key;
    if (window.event) {
        key = window.event.keyCode;
    }
    else if (e) {
        key = e.which;
    }
    else {
        return true;
    }

    if (key == 8 || key == 37 || key == 39 || key == 46)
        return true;

    var iNumericVal = "";
    for (i = 0; i < sText.length; i++) {
        Char = sText.charAt(i);
        if (Char == "-" && i == 0) {
            iNumericVal += Char;
        }
        if (InValidChars.indexOf(Char) == -1) {
            iNumericVal += Char;
        }

    }

    document.getElementById(e.id).value = "";

    if (iNumericVal.indexOf(".") > -1)
        iNumericVal = iNumericVal.substring(0, iNumericVal.indexOf(".") + 3);

    var straDecimal = iNumericVal.split(".");
    if (straDecimal.length > 2) iNumericVal = 0;

    if (iNumericVal == "") iNumericVal = 0;

    document.getElementById(e.id).value = iNumericVal;

    //document.getElementById(e.id).focus();
    return IsNumber;

}
/* date validation starts here */

// Declaring valid date character, minimum year and maximum year
var dtCh = "/";
var minYear = 1900;
var maxYear = 9999;

function isInteger(s) {
    var i;
    for (i = 0; i < s.length; i++) {
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag) {
    var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++) {
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function daysInFebruary(year) {
    // February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ((!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28);
}
function DaysArray(n) {
    for (var i = 1; i <= n; i++) {
        this[i] = 31
        if (i == 4 || i == 6 || i == 9 || i == 11) { this[i] = 30 }
        if (i == 2) { this[i] = 29 }
    }
    return this
}

function tIsDate(strObjectId) {
    if (document.getElementById(strObjectId)) {

        var dtStr = document.getElementById(strObjectId).value;
        if (dtStr == "") return true;
        var daysInMonth = DaysArray(12)
        var pos1 = dtStr.indexOf(dtCh)
        var pos2 = dtStr.indexOf(dtCh, pos1 + 1)
        var strMonth = dtStr.substring(0, pos1)
        var strDay = dtStr.substring(pos1 + 1, pos2)
        var strYear = dtStr.substring(pos2 + 1)
        strYr = strYear
        if (strDay.charAt(0) == "0" && strDay.length > 1) strDay = strDay.substring(1)
        if (strMonth.charAt(0) == "0" && strMonth.length > 1) strMonth = strMonth.substring(1)
        for (var i = 1; i <= 3; i++) {
            if (strYr.charAt(0) == "0" && strYr.length > 1) strYr = strYr.substring(1)
        }
        month = parseInt(strMonth)
        day = parseInt(strDay)
        year = parseInt(strYr)
        strYear = year.toString();

        var strTime = new String();
        strTime = dtStr.substring(dtStr.indexOf(" "), dtStr.length);



        if (pos1 == -1 || pos2 == -1) {

            $('.form_err_message.error_mess').html("");
            $('.form_err_message.error_mess').html("The date format should be : mm/dd/yyyy");
            $('.form_err_message.error_mess').css("display", "block");
            return false
        }
        if (strMonth.length < 1 || month < 1 || month > 12) {

            $('.form_err_message.error_mess').html("");
            $('.form_err_message.error_mess').html("Please enter a valid month");
            $('.form_err_message.error_mess').css("display", "block");
            return false
        }
        if (strDay.length < 1 || day < 1 || day > 31 || (month == 2 && day > daysInFebruary(year)) || day > daysInMonth[month]) {
            WarningBox("Please enter a valid day");
            $('.form_err_message.error_mess').html("");
            $('.form_err_message.error_mess').html("Please enter a valid day");
            $('.form_err_message.error_mess').css("display", "block");
            return false
        }
        if (strYear.length != 4 || year == 0 || year < minYear || year > maxYear) {
            $('.form_err_message.error_mess').html("");
            $('.form_err_message.error_mess').html("Please enter a valid 4 digit year between " + minYear + " and " + maxYear);
            $('.form_err_message.error_mess').css("display", "block");
            return false
        }
        //        if (dtStr.indexOf(dtCh, pos2 + 1) != -1 || isInteger(stripCharsInBag(dtStr, dtCh)) == false) {
        //            WarningBox("Please enter a valid date");
        //            return false
        //        }

        //       if(!isValidTime(strTime)) 
        //            WarningBox("Invalid time format:");

    }
    $('.form_err_message.error_mess').html("");

    $('.form_err_message.error_mess').css("display", "none");
    return true
}



/* date validation ends here */

/* Validate  Time Function starts here */
function isValidTime(value) {
    var colonCount = 0;
    var hasMeridian = false;
    for (var i = 0; i < value.length; i++) {
        var ch = value.substring(i, i + 1);
        if ((ch < '0') || (ch > '9')) {
            if ((ch != ':') && (ch != ' ') && (ch != 'a') && (ch != 'A') && (ch != 'p') && (ch != 'P') && (ch != 'm') && (ch != 'M')) {
                return false;
            }
        }
        if (ch == ':') { colonCount++; }
        if ((ch == 'p') || (ch == 'P') || (ch == 'a') || (ch == 'A')) { hasMeridian = true; }
    }
    if ((colonCount < 1) || (colonCount > 2)) { return false; }
    var hh = value.substring(0, value.indexOf(":"));
    if ((parseFloat(hh) < 0) || (parseFloat(hh) > 23)) { return false; }
    if (hasMeridian) {
        if ((parseFloat(hh) < 1) || (parseFloat(hh) > 12)) { return false; }
    }
    if (colonCount == 2) {
        var mm = value.substring(value.indexOf(":") + 1, value.lastIndexOf(":"));
    } else {
        var mm = value.substring(value.indexOf(":") + 1, value.length);
    }
    if ((parseFloat(mm) < 0) || (parseFloat(mm) > 59)) { return false; }
    if (colonCount == 2) {
        var ss = value.substring(value.lastIndexOf(":") + 1, value.length);
    } else {
        var ss = "00";
    }
    if ((parseFloat(ss) < 0) || (parseFloat(ss) > 59)) { return false; }
    return true;
}

/*Validate Time function Ends Here */




/* ********************   NEW VALIDATION SCRIPT ENDS HERE ************************************ */



/* ======================================== VALIDATION ROUTINE ========================================

/* Function to validate required fields */

/* Function to check valid Email Address */

function CheckEmailID(paraEmail) {

    var sEmail = document.getElementById(paraEmail).value;

    var atsym = sEmail.indexOf("@");
    var period = sEmail.lastIndexOf('.');
    var space = sEmail.indexOf(' ');
    var length = sEmail.length - 1;

    if ((atsym < 1) || (period <= atsym + 1) || (period == length) || (space != -1)) {
        WarningBox('Please enter a valid email address !');
        document.getElementById(paraEmail).focus();
        return false;
    }
    return true;
}

/* Function to check special characters*/

function CheckSpecialChar(vObject, vType) {
    var iChars;
    var AlertMsg;

    if (vType == "String") {

        iChars = "`!@#$%^&*()+=-[]\\\;,./{}|\":<>?1234567890";
        AlertMsg = "Special characters are not allowed!";
    }
    else if (vType == "Numeric") {
        iChars = "`!@#$%^&*()+=-[]\\\;,./{}|\:<>? ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'''";
        AlertMsg = "Invalid value";

    }
    else if (vType == "AlphaNumeric") {
        iChars = "`!@#$%^&*()+=[]\\\';,./{}|\":<>?";
        AlertMsg = "Special characters are not allowed!";
    }
    else if (vType == "SingleQuote") {
        iChars = "'";
        AlertMsg = "Single quote is not allowed!";
    }
    for (var i = 0; i < document.getElementById(vObject).value.length; i++) {
        if (iChars.indexOf(document.getElementById(vObject).value.charAt(i)) != -1) {

            WarningBox(AlertMsg);
            document.getElementById(vObject).focus();
            return false;
        }
    }
    return true;
}

/* ======================================== STRING MANIPULATION ROUTINES ========================================


/*Function trim extra spaces */
function trim(inputString) {
    if (typeof inputString != "string") { return inputString; }
    var retValue = inputString;
    var ch = retValue.substring(0, 1);
    while (ch == " ") { // Check for spaces at the beginning of the string
        retValue = retValue.substring(1, retValue.length);
        ch = retValue.substring(0, 1);
    }
    ch = retValue.substring(retValue.length - 1, retValue.length);
    while (ch == " ") { // Check for spaces at the end of the string
        retValue = retValue.substring(0, retValue.length - 1);
        ch = retValue.substring(retValue.length - 1, retValue.length);
    }
    while (retValue.indexOf("  ") != -1) { // Note that there are two spaces in the string - look for multiple spaces within the string
        retValue = retValue.substring(0, retValue.indexOf("  ")) + retValue.substring(retValue.indexOf("  ") + 1, retValue.length); // Again, there are two spaces in each of the strings
    }
    return retValue; // Return the trimmed string back to the user
}


/* Function to format numbers*/
function formatNumber(obj, decimal) {
    //decimal  - the number of decimals after the digit from 0 to 3
    //-- Returns the passed number as a string in the xxx,xxx.xx format.

    anynum = eval(obj);

    divider = 10;
    switch (decimal) {
        case 0:
            divider = 1;
            break;
        case 1:
            divider = 10;
            break;
        case 2:
            divider = 100;
            break;
        default:  	 //for 3 decimal places
            divider = 1000;
    }

    workNum = Math.abs((Math.round(anynum * divider) / divider));

    workStr = "" + workNum

    if (workStr.indexOf(".") == -1) { workStr += "." }

    dStr = workStr.substr(0, workStr.indexOf(".")); dNum = dStr - 0
    pStr = workStr.substr(workStr.indexOf("."))

    while (pStr.length - 1 < decimal) { pStr += "0" }

    if (pStr == '.') pStr = '';

    //--- Adds a comma in the thousands place.    
    if (dNum >= 1000) {
        dLen = dStr.length
        dStr = parseInt("" + (dNum / 1000)) + "," + dStr.substring(dLen - 3, dLen)
    }

    //-- Adds a comma in the millions place.
    if (dNum >= 1000000) {
        dLen = dStr.length
        dStr = parseInt("" + (dNum / 1000000)) + "," + dStr.substring(dLen - 7, dLen)
    }
    retval = dStr + pStr
    //-- Put numbers in parentheses if negative.
    if (anynum < 0) { retval = "(" + retval + ")"; }

    //retval =  "$"+retval    //You could include a dollar sign in the return value.

    obj = retval;

    return obj
}

// Function to encode the text in textbox in the format in which it was entered //

function escapeValEnter(textarea, replaceWith) {
    /* textarea is reference to that object, replaceWith is string that will replace the encoded return */
    textarea.value = escape(textarea.value) //encode textarea string's carriage returns
    for (i = 0; i < textarea.value.length; i++)//loop through string, replacing carriage return encoding with HTML break tag
    {
        if (textarea.value.indexOf("%0D%0A") > -1) {
            textarea.value = textarea.value.replace("%0D%0A", replaceWith)  //Windows encodes returns as \r\n hex
        }
        else if (textarea.value.indexOf("%0A") > -1) {
            textarea.value = textarea.value.replace("%0A", replaceWith)  //Unix encodes returns as \n hex
        }
        else if (textarea.value.indexOf("%0D") > -1) {
            textarea.value = textarea.value.replace("%0D", replaceWith)  //Macintosh encodes returns as \r hex
        }
    }

    textarea.value = unescape(textarea.value) //unescape all other encoded characters
}

// Function to decode the encoded text //
function upescapeValEnter(textarea, replaceWith) {
    //textarea is reference to that object, replaceWith is string that will replace the encoded return
    textarea.value = escape(textarea.value) //encode textarea string's carriage returns
    for (i = 0; i < textarea.value.length; i++) //loop through string, replacing carriage return encoding with HTML break tag
    {
        if (textarea.value.indexOf(replaceWith) > -1) {
            textarea.value = textarea.value.replace(replaceWith, "%0D%0A") //Windows encodes returns as \r\n hex
        }
    }
    textarea.value = unescape(textarea.value) //unescape all other encoded characters
}

function SingleSelect(chkobj) {
    for (var item = 0; item < document.forms[0].elements.length; item++) {
        if (document.forms[0].elements[item].type == 'checkbox' && document.forms[0].elements[item].id != chkobj.id) {
            document.forms[0].elements[item].checked = false;
        }
    }
}

/* ======================================== ERROR/INFO/OK BOX ROUTINES ========================================

/* Note: In HTML / ASP USE BELOW FUNCTIONS. DO NOT USE SetTopStatus Function Directly */
function ErrorBox(strMessage) {
    SetTopStatus("error", strMessage, 'true');
}
function WarningBox(strMessage) {
    SetTopStatus("warning", strMessage, 'true');
}
function InfoBox(strMessage) {
    SetTopStatus("information", strMessage, 'true');
}
function QueryBox(strMessage) {
    SetTopStatus("query", strMessage, 'true');
}

function ClearTopStatus() {
    if (document.getElementById('divWarning') != null) {
        document.getElementById('divWarning').style.display = 'none';
    }
    else if (document.getElementById('divInformation') != null) {
        document.getElementById('divInformation').style.display = 'none';
    }
    else if (document.getElementById('divError') != null) {
        document.getElementById('divError').style.display = 'none';
    }
    else if (document.getElementById('divQuery') != null) {
        document.getElementById('divQuery').style.display = 'none';
    }

    if (document.getElementById('SpanTopStatus') != null)
        document.getElementById('SpanTopStatus').innerHTML = "";
}


/* NOTE: BELOW FUNCTIONS ARE PRIVATE AND NOT FOR REGULAR USE. 
MAKE SURE YOU GUYS USE RIGHT FUNCTION FOR RIGHT BOX. */
function SetTopStatus(strStatus, strMessage) {
    ClearTopStatus();
    SetTopStatusExt(strStatus, strMessage, 'true');
}

function SetTopStatusExt(strStatus, strMessage, tShow) {
    var ctldivGenMessage;
    var ctlSpanTopStatus;
    var strClassName = "";
    var strdivId = "";

    switch (strStatus.toLowerCase()) {
        case "warning":
            strClassName = "warning";
            strdivId = "divWarning"
            break;
        case "information":
            strClassName = "information";
            strdivId = "divInformation"
            break;
        case "error":
            strClassName = "error";
            strdivId = "divError"
            break;
        case "query":
            strClassName = "query";
            strdivId = "divQuery"
            break;
        default:
            strdivId = "divQuery"
    }
    ctlSpanTopStatus = document.getElementById('SpanTopStatus');
    if (ctlSpanTopStatus != null) {
        ctldivGenMessage = document.createElement("div");
        ctldivGenMessage.id = strdivId;
        ctldivGenMessage.className = strClassName;
        ctldivGenMessage.innerHTML = strMessage;
        (tShow == 'true') ? (ctldivGenMessage.style.display = 'block') : (ctldivGenMessage.style.display = 'none');

        ctlSpanTopStatus.appendChild(ctldivGenMessage);
    }
    else {
        alert('SpanTopStatus element not found in page! Create this element to show messages');
    }
}

function SetTopStatusExtDynamic(strStatus, strMessage, tShow, SpanID) {
    ClearTopStatus();
    var ctldivGenMessage;
    var ctlSpanTopStatus;
    var strClassName = "";
    var strdivId = "";

    switch (strStatus.toLowerCase()) {
        case "warning":
            strClassName = "warning";
            strdivId = "divWarning"
            break;
        case "information":
            strClassName = "information";
            strdivId = "divInformation"
            break;
        case "error":
            strClassName = "error";
            strdivId = "divError"
            break;
        case "query":
            strClassName = "query";
            strdivId = "divQuery"
            break;
        default:
            strdivId = "divQuery"
    }
    ctlSpanTopStatus = document.getElementById(SpanID);
    if (ctlSpanTopStatus != null) {
        ctldivGenMessage = document.createElement("div");
        ctldivGenMessage.id = strdivId;
        ctldivGenMessage.className = strClassName;
        ctldivGenMessage.innerHTML = strMessage;
        (tShow == 'true') ? (ctldivGenMessage.style.display = 'block') : (ctldivGenMessage.style.display = 'none');

        ctlSpanTopStatus.appendChild(ctldivGenMessage);
    }
    else {
        alert('SpanTopStatus element not found in page! Create this element to show messages');
    }
}


/* ========================== FUNCTION TO LIMIT TEXTAREA LENGTH ================================ */
/* ============== USE THE BELOW FUNCTION ON KEYUP EVENT OF TEXTAREA ==================== */

function canAddCharacter(objtextarea, maxChars) {
    var text = objtextarea.value;
    var iLen = ctlTextArea.length;
    if (iLen > maxChars) {
        text = text.substring(0, maxChars);
        objtextarea.value = text;
        return false;
    }
    //document.myform.limit.value = count-len;
}

/* ============== USE THE BELOW FUNCTION WHILE VALIDATING CONTROLS  ==================== */
function TValidateTextAreaLength(objTextArea, iLength, strFieldName) // function returns boolean.
{
    if (objTextArea.value.length > (iLength - 1)) {
        WarningBox(strFieldName + ' exceeds maximum length.\nMaximum allowed length is ' + iLength + ' characters.')
        return false;
    }
    return true;
}


/* === Function to check url */


function isURL(urlStr) {
    var strWarningMsg = "";
    strWarningMsg = "Invalid website url. i.e. http://www.domainname.com ";

    urlStr = trim(urlStr);

    if (urlStr.indexOf(" ") != -1) {
        WarningBox("Spaces are not allowed in a URL");
        return false;
    }

    if (urlStr == "" || urlStr == null) {
        return true;
    }

    urlStr = urlStr.toLowerCase();

    var specialChars = "\\(\\)><@,;:\\\\\\\"\\.\\[\\]";
    var validChars = "\[^\\s" + specialChars + "\]";
    var atom = validChars + '+';
    var urlPat = /^(http|https):\/\/(\w*)\.([\-\+a-z0-9]*)\.(\w*)/;
    var matchArray = urlStr.match(urlPat);

    if (matchArray == null) {
        WarningBox(strWarningMsg);
        return false;
    }

    var user = matchArray[2];
    var domain = matchArray[3];

    for (i = 0; i < user.length; i++) {
        if (user.charCodeAt(i) > 127) {
            WarningBox(strWarningMsg);
            return false;
        }
    }

    for (i = 0; i < domain.length; i++) {
        if (domain.charCodeAt(i) > 127) {
            WarningBox(strWarningMsg);
            return false;
        }
    }

    var atomPat = new RegExp("^" + atom + "$");
    var domArr = domain.split(".");
    var len = domArr.length;

    for (i = 0; i < len; i++) {
        if (domArr[i].search(atomPat) == -1) {
            WarningBox(strWarningMsg);
            return false;
        }
    }

    return true;
}



//------------------------------------------------ ------------------------//
//


function validate_date(oControl, boolAllowOverride) {
    if (oControl.value == "") return;

    var strWarning = "Date must be in the form MM/DD/YYYY or MM/DD/YY";
    var s = formatdate(oControl.value);

    // this is the monstrance regexp that finds match for mm/dd/yy or mm/dd/yyyy
    // found on www.regexlib.com
    var r = /^(?:(?:(?:0?[13578]|1[02])(\/|-|\.)31)\1|(?:(?:0?[1,3-9]|1[0-2])(\/|-|\.)(?:29|30)\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:0?2(\/|-|\.)29\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:(?:0?[1-9])|(?:1[0-2]))(\/|-|\.)(?:0?[1-9]|1\d|2[0-8])\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$/;
    var m = s.match(r);
    if (m != null) {
        oControl.value = s;
    }
    else {
        if (!boolAllowOverride) {
            oControl.focus();
            oControl.select();
            oControl.value = "";
            ErrorBox(strWarning);
            return false;
        }
        else {
            var strURL = "includes/rangewarning.htm";
            var strWindowFeatures = "help:no; status:off; dialogwidth:300px; dialogheight:200px;";
            var strWarningMessage = "Invalid Date<br>";
            var strWarningMessage = strWarningMessage + strWarning;
            str = showModalDialog(strURL, strWarningMessage, strWindowFeatures);
            if (str == "")
                return;
            else {
                oControl.focus();
                oControl.select();
                oControl.value = "";
                return false;
            }
        }
    }
}

function formatdate(s) {
    //alert(s.length);
    var cd = new Date();
    if (s.indexOf("/") != -1) {
        var t = s.split("/");
        if (t.length > 1) {
            // format month and day to mm and dd
            var m = t[0].length < 2 ? "0" + t[0] : t[0];
            var d = t[1].length < 2 ? "0" + t[1] : t[1];


            if (t.length == 2)
                s = m + "/" + d + "/" + cd.getFullYear();
            if (t.length == 3) {
                var y = s.substr(s.length - 3, 3);
                if (y.substr(0, 1) == "/") {
                    s = s.substr(0, s.length - 3);
                    if (y.substr(1, 1) < "4")
                        s = m + "/" + d + "/20" + y.substr(1, 2);
                    else
                        s = m + "/" + d + "/19" + y.substr(1, 2);
                }
            }
        }

    } else if (s.length == 2) {
        s = (((cd.getMonth() + 1).length > 1) ? (cd.getMonth() + 1) : "0" + (cd.getMonth() + 1)) + "/" + s + "/" + cd.getFullYear();
    } else if (s.length == 4) {
        s = s.substring(0, 2) + "/" + s.substring(2) + "/" + cd.getFullYear();
    } else if (s.length == 6) {
        s = s.substring(0, 2) + "/" + s.substring(2, 4) + "/" + String(cd.getFullYear()).substring(0, 2) + s.substring(4);
    } else if (s.length == 8) {
        s = s.substring(0, 2) + "/" + s.substring(2, 4) + "/" + s.substring(4);
    }
    //alert (s);
    return s;
}

// -------------------------------------------------------------------------//

function IsAlphaNumeric(valueToCompare) {
    var re = /^[0-9a-zA-Z ]+$/;
    return re.test(valueToCompare);
}
function IsValidateEmail(emailAddress) {
    var re = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9][a-zA-Z0-9.-]*[\.]{1}[a-zA-Z]{2,4}$/;
    return re.test(emailAddress);
}
function IsValidNumber() {
    var key;
    if (window.event) {
        key = window.event.keyCode;
    }
    else if (e) {
        key = e.which;
    }
    else {
        return false;
    }
    if (key > 47 && key < 58)
        return true;
    return false;
}

//Start date validator that return tru if date is valid, false otherwise.
function isValidDate(oControl) {
    var s = formatdate(oControl.value);
    var r = /^(?:(?:(?:0?[13578]|1[02])(\/|-|\.)31)\1|(?:(?:0?[1,3-9]|1[0-2])(\/|-|\.)(?:29|30)\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:0?2(\/|-|\.)29\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:(?:0?[1-9])|(?:1[0-2]))(\/|-|\.)(?:0?[1-9]|1\d|2[0-8])\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$/;
    var m = s.match(r);
    if (m != null) {
        oControl.value = s;
        return true;
    }
    else {
        return false;
    }
}
function isValidateDateValue(datevalue) {
    var s = formatdate(datevalue);
    var r = /^(?:(?:(?:0?[13578]|1[02])(\/|-|\.)31)\1|(?:(?:0?[1,3-9]|1[0-2])(\/|-|\.)(?:29|30)\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:0?2(\/|-|\.)29\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:(?:0?[1-9])|(?:1[0-2]))(\/|-|\.)(?:0?[1-9]|1\d|2[0-8])\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$/;
    var m = s.match(r);
    if (m != null) {
        return true;
    }
    else {
        return false;
    }
}
//End Date validator that return tru if date is valid, false otherwise.

//Start formatString works like string.Format("Name : {0}","Hello") function in C#

var formatString = function () {
    var s = arguments[0];
    for (var i = 0; i < arguments.length - 1; i++) {
        var reg = new RegExp("\\{" + i + "\\}", "gm");
        s = s.replace(reg, arguments[i + 1]);
    }
    return s;
}
//Start formatString works like string.Format("Name : {0}","Hello") function in C#


var endsWith = function () {
    var suffix = arguments[0];
    return this.indexOf(suffix, this.length - suffix.length) !== -1;
};

function removeTrailingComma(csvValue) {
    if (null != csvValue && csvValue.endsWith(','))
        csvValue = csvValue.substr(0, csvValue.length - 1);
    return csvValue;
}
