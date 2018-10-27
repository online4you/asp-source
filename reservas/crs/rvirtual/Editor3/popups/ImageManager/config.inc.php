<?
// $Id: config.inc.php, v 1.0 2004/04/14 17:35:27 bpfeifer Exp $
/**
* HTMLArea3 addon - ImageManager
* Based on Wei Zhuo's ImageManager
* @package Mambo Open Source
* @Copyright © 2004 Bernhard Pfeifer aka novocaine
* @ All rights reserved
* @ Mambo Open Source is Free Software
* @ Released under GNU/GPL License : http://www.gnu.org/copyleft/gpl.html
* @version $Revision: 1.0 $
**/

//************************** BEGIN CONFIGURATION *****************************//

//example, this is the actual file system path
//of the web server document root. e.g.
// Filesystem == /home/web/www.yourdomain.com 
$BASE_DIR = $_SERVER['DOCUMENT_ROOT'];

//the path where the browser sees the document root (i.e. http://www.yourdomain.com/)
$BASE_URL = "/";

//this is where the images will be stored relative to the $BASE_DIR (and $BASE_URL)
//this directory MUST be readable AND writable by the web server.
$BASE_ROOT = "images/stories"; 

//In safe mode, directory creation is not permitted.
$SAFE_MODE = false;

//************************** END CONFIGURATION *****************************//

$IMG_ROOT = $BASE_ROOT;

if(strrpos($BASE_DIR, '/')!= strlen($BASE_DIR)-1) 
	$BASE_DIR .= '/';

if(strrpos($BASE_URL, '/')!= strlen($BASE_URL)-1) 
	$BASE_URL .= '/';

//Built in function of dirname is faulty
//It assumes that the directory nane can not contain a . (period)
function dir_name($dir) 
{
	$lastSlash = intval(strrpos($dir, '/'));
	if($lastSlash == strlen($dir)-1){
		return substr($dir, 0, $lastSlash);
	}
	else
		return dirname($dir);
}

?>