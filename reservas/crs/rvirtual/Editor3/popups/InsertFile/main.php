<?
// $Id: main.php, v 1.01.4 2004/04/19 12:05:04 bpfeifer Exp $
/**
* HTMLArea3 XTD addon - InsertFile
* Based on Al Rashid's File Manager
* @package Mambo Open Source
* @Copyright © 2004 Bernhard Pfeifer aka novocaine
* @ All rights reserved
* @ Mambo Open Source is Free Software
* @ Released under GNU/GPL License : http://www.gnu.org/copyleft/gpl.html
* @version $Revision: 1.01.4 $
**/

$MY_DOCUMENT_ROOT = $_SERVER['DOCUMENT_ROOT']."/dmdocuments";
$MY_BASE_URL = '/dmdocuments';
$MY_ALLOW_EXTENSIONS	= array('html', 'doc', 'xls', 'txt', 'gif', 'pdf', 'gz', 'tar', 'zip', 'rar', 'bzip', 'sql', 'swf', 'mov', 'mp3', 'wav');
$MY_DENY_EXTENSIONS		= array('php', 'php3', 'php4', 'phtml', 'shtml', 'cgi', 'pl'); 
//$MY_LIST_EXTENSIONS		= array('html', 'doc', 'xls', 'txt', 'gif', 'jpeg', 'jpg', 'png', 'pdf');
$MY_LIST_EXTENSIONS		= array('html', 'doc', 'xls', 'txt', 'pdf', 'gz', 'tar', 'zip', 'rar', 'sql', 'swf', 'mov', 'mp3', 'wav');
$MY_ALLOW_DELETE_FILE 	= true;
$MY_ALLOW_UPLOAD_FILE 	= true;
$MY_MAX_FILE_SIZE 		= 2*1024*1024;
$MY_URL_TO_OPEN_FILE 	= $_SERVER['DOCUMENT_ROOT']."/dmdocuments";
$MY_ALLOW_DELETE_FOLDER = true;
$MY_ALLOW_CREATE_FOLDER = true;
$MY_LANG 							= 'de';
$MY_DATETIME_FORMAT		= "d.m.Y H:i";

// DO NOT EDIT BELOW
$MY_NAME = 'inserfiledialog';
$lang_file = 'lang/lang-'.$MY_LANG.'.php';
if (is_file('lang/lang-'.$MY_LANG.'.php')) {
	require($lang_file);
} else {
	require('lang/lang-sp.php');
}
$MY_PATH = '/';
$MY_UP_PATH = '/';


