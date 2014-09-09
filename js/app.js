(function() {
  var Calendar, CalendarShell, DAYS_IN_MONTH, DAY_LABELS, DayCell, DayGrid, DaysOfWeek, EventDetails, EventEntry, FEED_URL, MONTH_LABELS, MonthHeading, R, WeekRow;

  $(function() {
    var cal;
    return cal = new Calendar();
  });

  DAY_LABELS = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

  MONTH_LABELS = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

  DAYS_IN_MONTH = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  FEED_URL = "https://www.googleapis.com/calendar/v3/calendars/" + "infilexfil.com_ij0amp5h2lir3tlf4sqfpb2geo@group.calendar.google.com" + "/events?key=AIzaSyCJq9lb_y7fnomgGFsDFBRzngucKZL-Ri8";

  Calendar = function(month, year) {
    this.month = (isNaN(month) || (month == null) ? new Date().getMonth() : month);
    this.year = (isNaN(year) || (year == null) ? new Date().getFullYear() : year);
    React.renderComponent(MonthHeading({
      monthLabel: MONTH_LABELS[this.month]
    }), document.getElementById("month-heading"));
    return React.renderComponent(CalendarShell({
      currentMonth: this.month,
      dayHeadings: DAY_LABELS,
      monthLength: DAYS_IN_MONTH[this.month],
      startOffset: new Date(this.year, this.month, 1).getDay(),
      url: FEED_URL,
      pollInterval: 12 * 60 * 60 * 1000
    }), document.getElementById("calendar"));
  };

  R = React.DOM;

  MonthHeading = React.createClass({
    render: function() {
      return R.span({
        "class": "month-heading"
      }, "" + this.props.monthLabel + " " + (new Date().getFullYear()));
    }
  });

  CalendarShell = React.createClass({
    loadCalendarFeed: function() {
      return $.get(this.props.url, (function(data) {
        if (this.isMounted()) {
          return this.setState({
            eventsList: data.items
          });
        }
      }).bind(this));
    },
    getInitialState: function() {
      return {
        eventsList: []
      };
    },
    componentDidMount: function() {
      this.loadCalendarFeed();
      return setInterval(this.loadCalendarFeed, this.props.pollInterval);
    },
    render: function() {
      return R.table({
        id: "calendar",
        className: "calendar"
      }, DaysOfWeek({
        dayHeadings: this.props.dayHeadings
      }), DayGrid({
        currentMonth: this.props.currentMonth,
        monthLength: this.props.monthLength,
        startOffset: this.props.startOffset,
        eventsList: this.state.eventsList
      }));
    }
  });

  DaysOfWeek = React.createClass({
    render: function() {
      var dayHeading;
      return R.thead({
        className: "days-of-week"
      }, R.tr(null, (function() {
        var _i, _len, _ref, _results;
        _ref = this.props.dayHeadings;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          dayHeading = _ref[_i];
          _results.push(R.th({
            className: "days-of-week--label"
          }, "" + dayHeading));
        }
        return _results;
      }).call(this)));
    }
  });

  DayGrid = React.createClass({
    getCurrentEvents: function() {
      var currentEvent, eventMonth, eventResults, _i, _len, _ref;
      eventResults = [];
      _ref = this.props.eventsList;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        currentEvent = _ref[_i];
        eventMonth = new Date(currentEvent.start.dateTime).getMonth();
        if (eventMonth === this.props.currentMonth) {
          eventResults.push(currentEvent);
        }
      }
      return eventResults;
    },
    render: function() {
      var currentEvents, days;
      currentEvents = this.getCurrentEvents();
      return R.tr({
        id: "day-grid"
      }, R.td({
        colSpan: 7
      }, (function() {
        var _i, _ref, _results;
        _results = [];
        for (days = _i = 1, _ref = this.props.monthLength + this.props.startOffset; _i <= _ref; days = _i += 7) {
          _results.push(WeekRow({
            rowHeight: 100 / Math.ceil((this.props.monthLength + this.props.startOffset) / 7) + "%",
            currentEvents: currentEvents,
            startOffset: days < 8 ? this.props.startOffset : 0,
            daysCounted: days < 8 ? days : days - this.props.startOffset,
            monthLength: this.props.monthLength
          }));
        }
        return _results;
      }).call(this)));
    }
  });

  WeekRow = React.createClass({
    render: function() {
      var currentEvent, date, eventDate, eventsForDay, i, specialClass, styleRules;
      styleRules = {
        height: this.props.rowHeight
      };
      return R.div({
        className: "week-wrap",
        style: styleRules
      }, R.table({
        className: "week"
      }, (function() {
        var _i, _ref, _results;
        if (this.props.startOffset > 0) {
          _results = [];
          for (i = _i = 1, _ref = this.props.startOffset; 1 <= _ref ? _i <= _ref : _i >= _ref; i = 1 <= _ref ? ++_i : --_i) {
            _results.push(DayCell({
              date: "",
              specialClass: " day--outside"
            }));
          }
          return _results;
        }
      }).call(this), (function() {
        var _i, _j, _len, _ref, _ref1, _ref2, _results;
        _results = [];
        for (date = _i = _ref = this.props.daysCounted, _ref1 = this.props.daysCounted + 6 - this.props.startOffset; _ref <= _ref1 ? _i <= _ref1 : _i >= _ref1; date = _ref <= _ref1 ? ++_i : --_i) {
          eventsForDay = [];
          _ref2 = this.props.currentEvents;
          for (_j = 0, _len = _ref2.length; _j < _len; _j++) {
            currentEvent = _ref2[_j];
            eventDate = new Date(currentEvent.start.dateTime).getDate();
            if (eventDate === date) {
              eventsForDay.push(currentEvent);
            }
          }
          specialClass = "";
          specialClass += date <= this.props.monthLength ? "" : " day--outside";
          specialClass += date === new Date().getDate() ? " day--today" : "";
          _results.push(DayCell({
            date: date <= this.props.monthLength ? date : "",
            eventsForDay: eventsForDay,
            specialClass: specialClass
          }));
        }
        return _results;
      }).call(this)));
    }
  });

  DayCell = React.createClass({
    render: function() {
      var eventToday;
      return R.td({
        className: "day" + this.props.specialClass
      }, R.h3({
        className: "day-label"
      }, this.props.date), (function() {
        var _i, _len, _ref, _results;
        if (this.props.eventsForDay) {
          _ref = this.props.eventsForDay;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            eventToday = _ref[_i];
            _results.push(EventEntry({
              eventInfo: eventToday,
              onClick: this.showEvent
            }));
          }
          return _results;
        }
      }).call(this));
    }
  });

  EventEntry = React.createClass({
    getInitialState: function() {
      return {
        handledClick: false,
        showEventDetails: false
      };
    },
    componentDidMount: function() {
      return window.addEventListener('click', this.hideEvent);
    },
    showEvent: function(e) {
      return this.setState({
        handledClick: true,
        showEventDetails: true
      });
    },
    hideEvent: function(e) {
      var compareName, offsetName, targetName;
      offsetName = e.target.offsetParent.className;
      targetName = e.target.className;
      compareName = "event-details";
      if (offsetName !== compareName && targetName !== compareName) {
        if (this.state.showEventDetails && this.state.handledClick !== true) {
          this.setState({
            showEventDetails: false
          });
        }
        if (this.state.handledClick) {
          return this.setState({
            handledClick: false
          });
        }
      }
    },
    render: function() {
      return R.div({
        className: "event"
      }, R.h4({
        className: "event__label",
        onClick: this.showEvent
      }, R.span({
        className: "event__time"
      }, "" + (moment(this.props.eventInfo.start.dateTime).format("H:mm")) + " "), R.span({
        className: "event__summary"
      }, "" + this.props.eventInfo.summary)), this.state.showEventDetails ? EventDetails({
        eventInfo: this.props.eventInfo
      }) : void 0);
    }
  });

  EventDetails = React.createClass({
    render: function() {
      return R.div({
        className: "event-details"
      }, R.h2({
        className: "event-details__title"
      }, "" + this.props.eventInfo.summary), R.p({
        className: "event-details__date"
      }, "" + (moment(this.props.eventInfo.start.dateTime).format("H:mm")) + " - " + (moment(this.props.eventInfo.end.dateTime).format("H:mm"))), R.p({
        className: "event-details__description"
      }, "" + this.props.eventInfo.description));
    }
  });

}).call(this);

//# sourceMappingURL=app.js.map
