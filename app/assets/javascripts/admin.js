Musicat.Admin = {};

Musicat.Admin.FrontEnd = {

  _onReady: {
    initialize: function() {
      this.addListeners();
    },
    addListeners: function() {
      Musicat.Admin.FrontEnd.listeners.checkbox.keypress();
      Musicat.Admin.FrontEnd.listeners.pictureSelect.select();
    }
  },


  listeners: {
    checkbox: {
      keypress: function() {
        Array.from(document.getElementsByClassName('mca_form_input_checkbox_visible')).forEach(element => {
          element.addEventListener('keypress', function(event) { Musicat.Admin.FrontEnd.responders.checkbox.toggleOnSpace(event) })
        });
        Array.from(document.getElementsByClassName('mca_form_input_destroybox_visible')).forEach(element => {
          element.addEventListener('keypress', function(event) { Musicat.Admin.FrontEnd.responders.checkbox.toggleOnSpace(event) })
        });
      }
    },
    pictureSelect: {
      select: function() {
        Array.from(document.getElementsByClassName('mca_form_input_select_picture')).forEach(element => {
          element.addEventListener('change', function(event) { Musicat.Admin.FrontEnd.responders.pictureSelect.changeThumbnail(event) })
        });
      }
    }
  },


  responders: {
    checkbox: {
      toggleOnSpace: function(event) {
        if (event.which === 32) {
          event.preventDefault();
          var checkbox_visible = event.target;
          var checkbox_name = checkbox_visible.getAttribute('for');
          var checkbox_legacy = document.getElementById(checkbox_name);
          switch (checkbox_legacy.checked) {
            case true:
              checkbox_legacy.checked = false;
              break;
            case false:
              checkbox_legacy.checked = true;
              break;
          }
        }
      }
    },
    pictureSelect: {
      changeThumbnail: function(event) {
        var select = event.target;
        var option = select.getElementsByTagName('OPTION')[select.selectedIndex];
        var source = option.getAttribute('data-picture-src');
        var thumbnail = select.closest('.mca_form_attribute').querySelector('.mca_form_thumbnail_image');
        thumbnail.setAttribute('src', source);
      }
    }
  }

};
