<?php
    class functions{
        private $db;
        private $sql;
        private $result;

        //constructor
        function __construct()
        {
            require_once 'DbConnection.php';
            $this->db = new Dbconnection;
            $this->db->connect();
        }

        function __destruct()
        {
            $this->db->connect()->close();
        }

        //methods
        public function insert_product($tablename, $fields, $values){
            $count = count($fields);
            $this->sql = "INSERT INTO $tablename(";
            for($i=0; $i < $count; $i++){
                $this->sql .= $fields[$i];
                if($i < $count - 1){
                    $this->sql .= ",";
                }else{
                    $this->sql .= ") VALUES(";
                }
            }
            for ($i=0; $i < $count; $i++){
                $this->sql .= "'".$values[$i]."'";
                if($i < $count -1){
                    $this->sql .= ",";
                }else{
                    $this->sql .= ");";
                }
            }
            $this->result = $this->db->connect()->query($this->sql);
            if($this->result === TRUE){
                return true;
            }else{
                return false;
            }
        }

        //view Product
        public function get_products($tablename) {
            $this->sql = "SELECT * FROM $tablename";
            $this->result = $this->db->connect()->query($this->sql);
    
            if ($this->result->num_rows > 0) {
                $products = [];
                while ($row = $this->result->fetch_assoc()) {
                    $products[] = $row;
                }
                return $products;
            } else {
                return false;
            }
        }
    }
?>