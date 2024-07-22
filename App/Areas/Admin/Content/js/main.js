(function () {
    'use strict';

    var treeviewMenu = $('.app-menu')

    // Toggle Sidebar
    $('[data-toggle="sidebar"]').click(function (e) {
        e.preventDefault()
        $('.app').toggleClass('sidenav-toggled')
    });

    // Activate sidebar treeview toggle
    $("[data-toggle='treeview']").click(function (e) {
        e.preventDefault();
        if (!$(this).parent().hasClass('is-expanded')) {
            treeviewMenu.find("[data-toggle='treeview']").parent().removeClass('is-expanded')
        }
        $(this).parent().toggleClass('is-expanded');
    });

    // Set initial active toggle
    $("[data-toggle='treeview.'].is-expanded").parent().toggleClass('is-expanded')

    // Activate bootstrip tooltips
    $("[data-toggle='tooltip']").tooltip()

    // Time
    window.onload = function time() {
        Number.prototype.pad = function () {
            let s = String(this)
            while (s.length < 2) { s = '0' + s }
            return s
        }

        var today = new Date()
        var dayOfWeek = ['Chủ Nhật', 'Thứ Hai', 'Thứ Ba', 'Thứ Tư', 'Thứ Năm', 'Thứ Sáu', 'Thứ Bảy']

        var nowDate = `${dayOfWeek[today.getDay()]}, ${today.getDate().pad()}/${(today.getMonth() + 1).pad()}/${today.getFullYear()}`;
        var nowTime = `${today.getHours()} giờ ${today.getMinutes().pad()} phút ${today.getSeconds().pad()} giây`;

        $('#clock').html(`<span>${nowDate} - ${nowTime}</span>`)
        setTimeout(function () { time() }, 1000);
    }

    // Check all
    $('#all').click(function () {
        $('#sampleTable tbody :checkbox').prop('checked', $(this).is(':checked'));
        e.stopImmediatePropagation();
    });

    // Search
    $(document).ready(function () {
        $('#search').on('input', function () {
            var value = $(this).val().toLowerCase();
            $('#sampleTable tbody tr').filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            })
            let rows = $('#sampleTable tr:visible').length
            $('.search-bar span.quantity').html(String(rows - 1))
        })
    })

    // Upload image
    $(".button-upload-image input").change(function (event) {
        const files = event.target.files;
        if (files.length == 0) return;

        // Append preview image
        const img = document.createElement('img');
        img.src = URL.createObjectURL(files[0]);
        img.classList.add('upload-image');
        $('#preview-images-container').append(img);

        // Clone and append label
        const label = $('.button-upload-image:last');

        const input = label.clone(true, true);
        input.css('display', 'inline-block');
        input.children('input').val('');

        label.children('input').attr('name', 'images');
        label.css('display', 'none');
        $('#upload-images-container').append(input);
    })
})();
