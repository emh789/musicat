Musicat = {};

Musicat.FrontEnd = {

  _onReady: {
    initialize: function() {
      this.addListeners();
      this.updateElementData();
    },
    addListeners: function() {
      Musicat.FrontEnd.listeners.navSelect.blur();
      Musicat.FrontEnd.listeners.navSelect.focus();
      Musicat.FrontEnd.listeners.mcActive.link();
      Musicat.FrontEnd.listeners.mcActive.filter();
      Musicat.FrontEnd.listeners.mcActive.select();
      Musicat.FrontEnd.listeners.yowl.trackLink();
    },
    updateElementData: function() {
      var emailAddresses = document.querySelectorAll('a.mc_active_address_email');
      emailAddresses.forEach(function(addr) {
        Musicat.FrontEnd.adjusters.contactInfo.anchor.text_fill(addr);
      });
    }
  },


  adjusters: {
    contactInfo: {
      anchor: {
        text_fill: function(anchor) {
          var recipient = anchor.getAttribute('data-recipient');
          var domain = anchor.getAttribute('data-domain');
          var address = (recipient + '@' + domain);
          var href = ('mailto:' + address);
          anchor.textContent = address;
          anchor.setAttribute('href', href);
        }
      }
    }
  },


  listeners: {
    // several button-like elements imply actions
    mcActive: {
      link: function() {
        Array.from(document.getElementsByClassName('mc_active_link_container')).forEach(element => {
          element.addEventListener('click', function(event) { Musicat.FrontEnd.responders.linkContainer.click(event, 'data-url') })
        });
      },
      filter: function() {
        Array.from(document.getElementsByClassName('mc_active_filter')).forEach(element => {
          element.addEventListener('change', function(event) { Musicat.FrontEnd.responders.linkFilterSelect.change(event, 'data-url') })
        });
      },
      select: function() {
        Array.from(document.getElementsByClassName('mc_active_select')).forEach(element => {
          element.addEventListener('change', function(event) { Musicat.FrontEnd.responders.linkFilterSelect.change(event, 'data-url') })
        });
      }
    },
    // the public nav elemnt has nested elements to ensure a look-and-feel consistent with other button-like elements
    // blur and focus event handlers ensure visual consistency across states
    navSelect: {
      blur: function() {
        var nav = document.getElementById('mc_header_nav_select')
        if ((nav) && (nav.type === 'select-one')) {
          nav.addEventListener('blur', function(event) { Musicat.FrontEnd.responders.navSelect.blur(event) });
        }
      },
      focus: function() {
        var nav = document.getElementById('mc_header_nav_select')
        if ((nav) && (nav.type === 'select-one')) {
          nav.addEventListener('focus', function(event) { Musicat.FrontEnd.responders.navSelect.focus(event) });
        }
      }
    },
    // the yowl media UI responds to keypress events and triggers amplitudeJS actions
    yowl: {
      trackLink: function() {
        Array.from(document.getElementsByClassName('yowl_track_link')).forEach(element => {
          element.addEventListener('keypress', function(event) { Musicat.FrontEnd.yowl.chooseTrack(event) })
        });
      }
    }
  },


  responders: {
    linkContainer: {
      click: function(event, attribute) {
        event.preventDefault();
        var target = event.target;
        if (target.classList.contains('mc_active_link_container')) {
          var url = target.getAttribute(attribute);
        } else {
          var parentRow = target.closest('.mc_active_link_container');
          var url = parentRow.getAttribute(attribute);
        }
        window.location.href = url;
      }
    },
    linkFilterSelect: {
      change: function(event, attribute) {
        event.preventDefault();
        var select = event.target;
        var option = select.getElementsByTagName('OPTION')[select.selectedIndex];
        var destination = option.getAttribute(attribute);
        select.querySelector('[selected="selected"]').selected = true;  // restore the initial selection in case of a browser 'back' action
        window.location.href = destination;
      }
    },
    navSelect: {
      blur: function(event) {
        var select = event.target;
        var container = select.closest('#mc_header_nav');
        container.classList.remove('mc_outline');
      },
      focus: function(event) {
        var select = event.target;
        var container = select.closest('#mc_header_nav');
        container.classList.add('mc_outline');
      }
    }
  },


  yowl: {
    chooseTrack: function(event) {
      if (event.which === 13) {
        event.preventDefault();
        var title = event.target;
        var track = title.closest('.amplitude-play');
        var index = track.getAttribute('data-amplitude-song-index');
        Amplitude.playSongAtIndex(index);
      }
    }
  }


};
