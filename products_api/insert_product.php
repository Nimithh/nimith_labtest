<?php
    include 'function.php';
    $result = array("success" => 0, "error" => 0);

    if (
        isset($_POST['ProductName']) &&
        isset($_POST['Description']) &&
        isset($_POST['CategoryID']) &&
        isset($_POST['Barcode']) &&
        isset($_POST['ExpiredDate']) &&
        isset($_POST['Qty']) &&
        isset($_POST['UnitPriceIn']) &&
        isset($_POST['UnitPriceOut'])
    ) {
        $productName = $_POST['ProductName'];
        $description = $_POST['Description'];
        $categoryID = $_POST['CategoryID'];
        $barcode = $_POST['Barcode'];
        $expiredDate = $_POST['ExpiredDate'];
        $qty = $_POST['Qty'];
        $unitPriceIn = $_POST['UnitPriceIn'];
        $unitPriceOut = $_POST['UnitPriceOut'];
        $productImage = isset($_POST['ProductImage']) ? $_POST['ProductImage'] : "default.png";

        $fields = array("ProductName", "Description", "CategoryID", "Barcode", "ExpiredDate", "Qty", "UnitPriceIn", "UnitPriceOut");
        $values = array($productName, $description, $categoryID, $barcode, $expiredDate, $qty, $unitPriceIn, $unitPriceOut);

        $func = new functions();
        $insert = $func->insert_product('tblproduct', $fields, $values);
        if ($insert == true) {
            $result["success"] = 1;
            $result["msg_success"] = "Product has been added successfully.";
            print json_encode($result);
        } else {
            $result["error"] = 2;
            $result["msg_error"] = "Failed to add the product.";
            print json_encode($result);
        }
    } else {
        $result["error"] = 1;
        $result["msg_error"] = "Access denied...";
        print json_encode($result);
    }
?>