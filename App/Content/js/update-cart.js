function addItem(idProduct) {
    $.post(`/Cart/AddItems?idProduct=${idProduct}&quantity=1`)
        .done(function () {
            location.reload();
        })
}

function minusItem(idProduct) {
    $.post(`/Cart/MinusQuantity?idProduct=${idProduct}`)
        .done(function () {
            location.reload();
        })
}

function deleteItem(idProduct) {
    $.post(`/Cart/RemoveItem?idProduct=${idProduct}`)
        .done(function () {
            location.reload();
        })
}