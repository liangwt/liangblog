<?php
/**
 * Created by PhpStorm.
 * User: LiangWentao
 * Date: 12/29/2016
 * Time: 18:59
 */
function stripFirstCharst($str=""){
    $str = htmlspecialchars_decode($str);
    $firstCharst = stristr($str, "<br/>",true);
    return $firstCharst;
}