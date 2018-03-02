<?php

namespace Admin\Common;

class Textarea
{
	private $_string;
	
	public function __construct($string)
	{
		$this->_string = $string;
	}
	
	public function convertEnterToBr()
	{
		if (false !== strpos($this->_string, "\n")) {
			return str_replace("\n", '<br/>', $this->_string);
		}
		
		return $this->_string;
	}
	
	public function convertBrToEnter()
	{
		if (false !== strpos($this->_string, '<br/>')) {
			return str_replace('<br/>', "\n", $this->_string);
		}
		
		return $this->_string;
	}
	
	public function convertEnterToNone()
	{
		if (false !== strpos($this->_string, "\n")) {
			$this->_string = str_replace("\n", '', $this->_string);
		}
		if (false !== strpos($this->_string, "\r")) {
			return str_replace("\r", '', $this->_string);
		}
		
		return $this->_string;
	}
	
	public function convertEnterToP()
	{
		if (false !== strpos($this->_string, "\n")) {
			$temp_arr = explode("\n", $this->_string);
			$temp_str = '';
			foreach ($temp_arr as $item) {
				$temp_str .= '<p>' . $item . '</p>';
			}
			return $temp_str;
		}
		
		return '<p>' . $this->_string . '</p>';
	}
	
	public function convertPToEnter()
	{
		if (false !== strpos($this->_string, "</p>") || false !== strpos($this->_string, "<p>")) {
			$temp_str = str_replace('</p>', "\n", $this->_string);
			return str_replace('<p>', "", $temp_str);
		}
		
		return $this->_string;
	}
}