$('.click-eye').click(function () {
    $(this).toggleClass('bx-show bx-hide')
    var input = $($(this).attr('toggle'))
    if (input.attr('type') == 'password')
        input.attr('type', 'text')
    else
        input.attr('type', 'password')
});