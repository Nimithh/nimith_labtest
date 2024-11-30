<?php
    include 'function.php';

    $functions = new functions();

    $products = $functions->get_products('tblproduct');

    if ($products) {
        echo json_encode(['success' => 1, 'products' => $products]);
    } else {
        echo json_encode(['success' => 0, 'msg_error' => 'No products found']);
    }

?>
