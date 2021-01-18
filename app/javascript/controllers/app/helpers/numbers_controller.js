import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["1111", "2222", "3333", "4444", "5555", "6666", "7777", "8888", "9999"]

  connect() {
  }

  fromNumberToPretty(element) {
    var elementPretty = element.priceFormat({
      prefix: '',
      centsLimit: 0,
      thousandsSeparator: '.',
    });

    return elementPretty
  }

  fromTaxIdToNumber(value) {
    return value.replace(".", "").replace(".", "").replace(".", "").replace("-", "").replace("/", "")
  }

  fromCpfToNumber(value) {
    return value.replace(".", "").replace(".", "").replace(".", "").replace("-", "").replace("/", "")
  }

  fromCnpjToNumber(value) {
    return value.replace(".", "").replace(".", "").replace(".", "").replace("-", "").replace("/", "")
  }

  fromCurrencyToNumber(value) {
    return value.replace("R$ ", "").replace(".", "").replace(".", "").replace(",", ".")
  }

  fromPercentToNumber(value) {
    return value.replace(" %", "").replace(".", "").replace(".", "").replace(",", ".")
  }

  fromPhoneToNumber(value) {
    return value.replace("-", "").replace(" ", "")
  }

  fromZipToNumber(value) {
    return value.replace(".", "").replace("-", "")
  }

  fromDateToNumber(value) {
    return value.replace("/", "").replace("/", "")
  }

  changeNumberToCpf(ev) {
    if (ev.type == "keypress") {
      var v = ev.target.value
      var vLength = this.fromCpfToNumber(v)
      var functional = this.filterKeyCheck(ev);

      if (functional === true && vLength.length < 11) {
        var value = this.cpfMask(ev.target.value)
        ev.target.value = value
      } else {
        ev.preventDefault()
        ev.stopPropagation()
        ev.target.value = v
      }
    } else if (ev.type == "blur") {
      ev.target.value = this.cpfMask(ev.target.value)
    }
  }

  cpfMask(value) {
    value = this.fromCpfToNumber(value);
    if (value.length === 0) {
      return value;
    } else if (value.length === 1) {
      return value;
    } else if (value.length === 2) {
      return value;
    } else if (value.length === 3) {
      return value.replace(/(\d{3})/g, "\$1.");
    } else if (value.length === 4) {
      return value.replace(/(\d{3})/g, "\$1.");
    } else if (value.length === 5) {
      return value.replace(/(\d{3})/g, "\$1.");
    } else if (value.length === 6) {
      return value.replace(/(\d{3})(\d{3})/g, "\$1.\$2.");
    } else if (value.length === 7) {
      return value.replace(/(\d{3})(\d{3})/g, "\$1.\$2.");
    } else if (value.length === 8) {
      return value.replace(/(\d{3})(\d{3})/g, "\$1.\$2.");
    } else if (value.length === 9) {
      return value.replace(/(\d{3})(\d{3})(\d{3})/g, "\$1.\$2.\$3\-");
    } else if (value.length === 10) {
      return value.replace(/(\d{3})(\d{3})(\d{3})(\d{1})/g, "\$1.\$2.\$3\-\$4");
    } else if (value.length === 11) {
      return value.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/g, "\$1.\$2.\$3\-\$4");
    }
    return value
  }

  changeNumberToCnpj(ev) {
    if (ev.type == "keypress") {
      var v = ev.target.value
      var vLength = this.fromCnpjToNumber(v)
      var functional = this.filterKeyCheck(ev);

      if (functional === true && vLength.length < 14) {
        var value = this.cnpjMask(ev.target.value)
        ev.target.value = value
      } else {
        ev.preventDefault()
        ev.stopPropagation()
        ev.target.value = v
      }
    } else if (ev.type == "blur") {
      ev.target.value = this.cnpjMask(ev.target.value)
    }
  }

  cnpjMask(value) {
    value = this.fromCnpjToNumber(value);
    if (value.length === 0) {
      return value;
    } else if (value.length === 1) {
      return value;
    } else if (value.length === 2) {
      return value.replace(/(\d{2})/g, "\$1.");
    } else if (value.length === 3) {
      return value.replace(/(\d{2})/g, "\$1.");
    } else if (value.length === 4) {
      return value.replace(/(\d{2})(\d{2})/g, "\$1.\$2");
    } else if (value.length === 5) {
      return value.replace(/(\d{2})(\d{3})/g, "\$1.\$2.");
    } else if (value.length === 6) {
      return value.replace(/(\d{2})(\d{3})/g, "\$1.\$2.");
    } else if (value.length === 7) {
      return value.replace(/(\d{2})(\d{3})/g, "\$1.\$2.");
    } else if (value.length === 8) {
      return value.replace(/(\d{2})(\d{3})(\d{3})/g, "\$1.\$2.\$3/");
    } else if (value.length === 9) {
      return value.replace(/(\d{2})(\d{3})(\d{3})/g, "\$1.\$2.\$3/");
    } else if (value.length === 10) {
      return value.replace(/(\d{2})(\d{3})(\d{3})/g, "\$1.\$2.\$3/");
    } else if (value.length === 11) {
      return value.replace(/(\d{2})(\d{3})(\d{3})/g, "\$1.\$2.\$3/");
    } else if (value.length === 12) {
      return value.replace(/(\d{2})(\d{3})(\d{3})(\d{4})/g, "\$1.\$2.\$3\/\$4\-");
    } else if (value.length === 13) {
      return value.replace(/(\d{2})(\d{3})(\d{3})(\d{4})/g, "\$1.\$2.\$3\/\$4\-");
    } else if (value.length === 14) {
      return value.replace(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{2})/g, "\$1.\$2.\$3\/\$4\-\$5");
    }
    return value
  }

  changeNumberToDoubleId(ev) {
    if (ev.type == "keypress") {
      var v = ev.target.value
      var vLength = this.fromTaxIdToNumber(v)
      var functional = this.filterKeyCheck(ev);

      if (functional === true && vLength.length < 11) {
        var value = this.cpfMask(ev.target.value)
        ev.target.value = value
      } else if (functional === true && vLength.length < 14) {
        var value = this.cnpjMask(ev.target.value)
        ev.target.value = value
      } else {
        ev.preventDefault()
        ev.stopPropagation()
        ev.target.value = v
      }
    } else if (ev.type == "blur") {
      var v = ev.target.value
      var vLength = this.fromTaxIdToNumber(v)

      if (vLength.length <= 11) {
        ev.target.value = this.cpfMask(ev.target.value)
      } else if (vLength.length <= 14) {
        ev.target.value = this.cnpjMask(ev.target.value)
      }
    }
  }

  changeNumberToPhone(ev) {
    var v = ev.target.value
    var vLength = this.fromPhoneToNumber(v)

    if (ev.type == "keyup") {
      var functional = this.filterKeyCheck(ev);
      if (functional === true && vLength.length < 9) {
        var value = this.phoneMask(ev.target.value)
        ev.target.value = value
      } else {
        ev.preventDefault()
        ev.stopPropagation()
        var value = this.fromPhoneToNumber(ev.target.value).slice(0, 9)
        ev.target.value = this.phoneMask(value)
      }
    } else if (ev.type == "blur") {
      ev.target.value = this.phoneMask(v)
    }
  }

  phoneMask(value) {

    value = this.fromPhoneToNumber(value)
    
    if (value.length === 0) {
      return value;
    } else if (value.length === 1) {
      return value;
    } else if (value.length === 2) {
      return value;
    } else if (value.length === 3) {
      return value;
    } else if (value.length === 4) {
      return value.replace(/(\d{4})(\d{0})/g, "\$1-\$2");
    } else if (value.length === 5) {
      return value.replace(/(\d{4})(\d{1})/g, "\$1-\$2");
    } else if (value.length === 6) {
      return value.replace(/(\d{4})(\d{2})/g, "\$1-\$2");
    } else if (value.length === 7) {
      return value.replace(/(\d{4})(\d{2})/g, "\$1-\$2");
    } else if (value.length === 8) {
      return value.replace(/(\d{4})(\d{2})/g, "\$1-\$2");
    } else if (value.length === 9) {
      return value.replace(/(\d{1})(\d{4})(\d{2})/g, "\$1 \$2-\$3");
    } else {
      return value.replace(/(\d{1})(\d{4})(\d{2})/g, "\$1 \$2-\$3");
    }
  }

  changeNumberToDDD(ev) {
    var v = ev.target.value
    var vLength = this.fromPhoneToNumber(v)

    if (ev.type == "keyup") {
      var functional = this.filterKeyCheck(ev);
      if (functional === true && vLength.length < 2) {
        ev.target.value = ev.target.value
      } else {
        ev.preventDefault()
        ev.stopPropagation()
        var value = this.fromPhoneToNumber(ev.target.value).slice(0, 2)
        ev.target.value = value
      }
    } else if (ev.type == "blur") {
      ev.target.value = this.phoneMask(v)
    }
  }

  changeNumberToZip(ev) {
    var v = ev.target.value
    var vLength = this.fromZipToNumber(v)

    if (ev.type == "keyup") {
      var functional = this.filterKeyCheck(ev);
      if (functional === true && vLength.length < 8) {
        var value = this.zipMask(ev.target.value)
        ev.target.value = value
      } else {
        ev.preventDefault()
        ev.stopPropagation()
        // var value = this.fromZipToNumber(ev.target.value).slice(0, 8)
        var value = ev.target.value.slice(0, 10)
        ev.target.value = value
      }
    } else if (ev.type == "blur") {
      ev.target.value = this.zipMask(v)
    }
  }

  zipMask(value) {

    value = this.fromZipToNumber(value)

    if (value.length === 0) {
      return value;
    } else if (value.length === 1) {
      return value;
    } else if (value.length === 2) {
      return value.replace(/(\d{2})/g, "\$1.");
    } else if (value.length === 3) {
      return value.replace(/(\d{2})(\d{1})/g, "\$1.\$2");
    } else if (value.length === 4) {
      return value.replace(/(\d{2})(\d{2})/g, "\$1.\$2");
    } else if (value.length === 5) {
      return value.replace(/(\d{2})(\d{3})/g, "\$1.\$2-");
    } else if (value.length === 6) {
      return value.replace(/(\d{2})(\d{3})(\d{1})/g, "\$1.\$2-\$3");
    } else if (value.length === 7) {
      return value.replace(/(\d{2})(\d{3})(\d{2})/g, "\$1.\$2-\$3");
    } else if (value.length === 8) {
      return value.replace(/(\d{2})(\d{3})(\d{3})/g, "\$1.\$2-\$3");
    }
    
  }

  changeNumberToCurrency(ev) {
    var value = ev.target.value
    value = value.replace("R$ ", "").replace(/\./g, "").replace(/,/g, "").replace(/^0+/, '')

    if (ev.type == "keypress") {
      var functional = this.filterKeyCheck(ev);

      if (functional === true) {
        ev.target.value = this.currencyMask(value)
      } else {
        ev.preventDefault()
        ev.stopPropagation()
        ev.target.value = this.currencyMask(value)
      }
    } else if (ev.type == "blur" || ev.type == "keyup") {
      ev.target.value = this.currencyMask(value)
    }
  }

  currencyMask(value) {
    value = value.toString().replace("R$ ", "").replace(/\./g, "").replace(/,/g, "").replace(/^0+/, '')
    var valueDec = value.substr(-2)
    var valueInt = (value - valueDec)/100

    if (value.length === NaN) {
      return "R$ 0,00"
    } else if (value.length === 0) {
      return "R$ 0,00"
    } else if (value.length === 1) {
      return "R$ 0,0" + value
    } else if (value.length === 2) {
      return "R$ 0," + value
    } else if (value.length === 3) {
      return "R$ " + valueInt + "," + valueDec
    } else if (value.length === 4) {
      return "R$ " + valueInt + "," + valueDec
    } else if (value.length === 5) {
      return "R$ " + valueInt + "," + valueDec
    } else if (value.length === 6) {
      valueInt = valueInt.toString().replace(/(\d{1})(\d{3})/g, "\$1.\$2");
      return "R$ " + valueInt + "," + valueDec
    } else if (value.length === 7) {
      valueInt = valueInt.toString().replace(/(\d{2})(\d{3})/g, "\$1.\$2");
      return "R$ " + valueInt + "," + valueDec
    } else if (value.length === 8) {
      valueInt = valueInt.toString().replace(/(\d{3})(\d{3})/g, "\$1.\$2");
      return "R$ " + valueInt + "," + valueDec
    } else if (value.length === 9) {
      valueInt = valueInt.toString().replace(/(\d{1})(\d{3})(\d{3})/g, "\$1.\$2.\$3");
      return "R$ " + valueInt + "," + valueDec
    } else if (value.length === 10) {
      valueInt = valueInt.toString().replace(/(\d{2})(\d{3})(\d{3})/g, "\$1.\$2.\$3");
      return "R$ " + valueInt + "," + valueDec
    } else if (value.length === 11) {
      valueInt = valueInt.toString().replace(/(\d{3})(\d{3})(\d{3})/g, "\$1.\$2.\$3");
      return "R$ " + valueInt + "," + valueDec
    } else if (value.length === 12) {
      valueInt = valueInt.toString().replace(/(\d{1})(\d{3})(\d{3})(\d{3})/g, "\$1.\$2.\$3.\$4");
      return "R$ " + valueInt + "," + valueDec
    } else if (value.length === 13) {
      valueInt = valueInt.toString().replace(/(\d{2})(\d{3})(\d{3})(\d{3})/g, "\$1.\$2.\$3.\$4");
      return "R$ " + valueInt + "," + valueDec
    } else if (value.length === 14) {
      valueInt = valueInt.toString().replace(/(\d{3})(\d{3})(\d{3})(\d{3})/g, "\$1.\$2.\$3.\$4");
      return "R$ " + valueInt + "," + valueDec
    }
  }


  changeNumberToPercent(ev) {
    var value = ev.target.value
    value = value.replace(" %", "").replace(/\./g, "").replace(/,/g, "").replace(/^0+/, '')
    if (ev.type == "keyup") {
      var functional = this.filterKeyCheck(ev);

      if (functional === true) {
        ev.target.value = this.percentMask(value)
      } else {
        ev.preventDefault()
        ev.stopPropagation()
        ev.target.value = this.percentMask(value)
      }
    } else if (ev.type == "blur" || ev.type == "keyup") {
      ev.target.value = this.percentMask(value)
    }
  }

  percentMask(value) {
    value = value.replace(" %", "").replace(/\./g, "").replace(/,/g, "").replace(/^0+/, '')
    var valueDec = value.substr(-2)
    var valueInt = (value - valueDec) / 100

    if (value.length === NaN) {
      return "0,00 %"
    } else if (value.length === 0) {
      return "0,00 %"
    } else if (value.length === 1) {
      return `0,0${value} %`
    } else if (value.length === 2) {
      return `0,${value} %`
    } else if (value.length === 3) {
      return `${valueInt},${valueDec} %`
    } else if (value.length === 4) {
      return `${valueInt},${valueDec} %`
    } else if (value.length === 5) {
      return `${valueInt},${valueDec} %`
    } else if (value.length === 6) {
      valueInt = valueInt.toString().replace(/(\d{1})(\d{3})/g, "\$1.\$2");
      return `${valueInt},${valueDec} %`
    } else if (value.length === 7) {
      valueInt = valueInt.toString().replace(/(\d{2})(\d{3})/g, "\$1.\$2");
      return `${valueInt},${valueDec} %`
    } else if (value.length === 8) {
      valueInt = valueInt.toString().replace(/(\d{3})(\d{3})/g, "\$1.\$2");
      return `${valueInt},${valueDec} %`
    } else if (value.length === 9) {
      valueInt = valueInt.toString().replace(/(\d{1})(\d{3})(\d{3})/g, "\$1.\$2.\$3");
      return `${valueInt},${valueDec} %`
    } else if (value.length === 10) {
      valueInt = valueInt.toString().replace(/(\d{2})(\d{3})(\d{3})/g, "\$1.\$2.\$3");
      return `${valueInt},${valueDec} %`
    } else if (value.length === 11) {
      valueInt = valueInt.toString().replace(/(\d{3})(\d{3})(\d{3})/g, "\$1.\$2.\$3");
      return `${valueInt},${valueDec} %`
    } else if (value.length === 12) {
      valueInt = valueInt.toString().replace(/(\d{1})(\d{3})(\d{3})(\d{3})/g, "\$1.\$2.\$3.\$4");
      return `${valueInt},${valueDec} %`
    } else if (value.length === 13) {
      valueInt = valueInt.toString().replace(/(\d{2})(\d{3})(\d{3})(\d{3})/g, "\$1.\$2.\$3.\$4");
      return `${valueInt},${valueDec} %`
    } else if (value.length === 14) {
      valueInt = valueInt.toString().replace(/(\d{3})(\d{3})(\d{3})(\d{3})/g, "\$1.\$2.\$3.\$4");
      return `${valueInt},${valueDec} %`
    }
  }

  numberMask(value) {
    value = parseInt(value).toString()

    if (value.length === NaN) {
      return "0"
    } else if (value.length === 0) {
      return "0"
    } else if (value.length === 1) {
      return `${value}`
    } else if (value.length === 2) {
      return `${value}`
    } else if (value.length === 3) {
      return `${value}`
    } else if (value.length === 4) {
      value = value.toString().replace(/(\d{1})(\d{3})/g, "\$1.\$2");
      return `${value}`
    } else if (value.length === 5) {
      value = value.toString().replace(/(\d{2})(\d{3})/g, "\$1.\$2");
      return `${value}`
    } else if (value.length === 6) {
      value = value.toString().replace(/(\d{3})(\d{3})/g, "\$1.\$2");
      return `${value}`
    } else if (value.length === 7) {
      value = value.toString().replace(/(\d{1})(\d{3})(\d{3})/g, "\$1.\$2.\$3");
      return `${value}`
    } else if (value.length === 8) {
      value = value.toString().replace(/(\d{2})(\d{3})(\d{3})/g, "\$1.\$2.\$3");
      return `${value}`
    } else if (value.length === 9) {
      value = value.toString().replace(/(\d{3})(\d{3})(\d{3})/g, "\$1.\$2.\$3");
      return `${value}`
    }
  }

  changeNumberToDate(ev) {
    if (ev.type == "keypress") {
      var v = ev.target.value
      var vLength = this.fromDateToNumber(v)
      var functional = this.filterKeyCheck(ev);

      if (functional === true && vLength.length < 8) {
        var value = this.dateMask(ev.target.value)
        ev.target.value = value
      } else {
        ev.preventDefault()
        ev.stopPropagation()
        ev.target.value = v
      }
    } else if (ev.type == "blur") {
      var v = ev.target.value
      var vLength = this.fromDateToNumber(v)
      if (vLength.length < 8) {
        var value = this.dateMask(ev.target.value)
        ev.target.value = value
      } else {
        ev.preventDefault()
        ev.stopPropagation()
        ev.target.value = v
      }
    }
  }

  dateMask(value) {
    value = this.fromDateToNumber(value);
    if (value.length === 0) {
      return value;
    } else if (value.length === 1) {
      return value;
    } else if (value.length === 2) {
      return value.replace(/(\d{2})/g, "\$1/");
    } else if (value.length === 3) {
      return value.replace(/(\d{2})/g, "\$1/");
    } else if (value.length === 4) {
      return value.replace(/(\d{2})(\d{2})/g, "\$1/\$2/");
    } else if (value.length === 5) {
      return value.replace(/(\d{2})(\d{2})/g, "\$1/\$2/");
    } else if (value.length === 6) {
      return value.replace(/(\d{2})(\d{2})/g, "\$1/\$2/");
    } else if (value.length === 7) {
      return value.replace(/(\d{2})(\d{2})/g, "\$1/\$2/");
    }
    return value
  }


  filterKeyCheck(e) {
    var code = (e.keyCode ? e.keyCode : e.which);
    var metaKey = e.metaKey;
    var functional = false;

    // allow key numbers, 0 to 9
    // if ((code >= 48 && code <= 57) || (code >= 96 && code <= 105)) functional = true;
    if (code >= 48 && code <= 57) functional = true;
    if (code == 192) functional = true;

    // check Backspace, Tab, Enter, Delete, and left/right arrows
    if (code == 8) functional = true;
    if (code == 9) functional = true;
    if (code == 13) functional = true;
    // if (code == 46) functional = true;
    if (code == 37) functional = true;
    if (code == 39) functional = true;
    // Minus Sign, Plus Sign
    //if ((code == 189 || code == 109 || code == 173)) functional = true;
    if ((code == 189 || code == 173)) functional = true;
    // if ((code == 187 || code == 107 || code == 61)) functional = true;
    if ((code == 187 || code == 61)) functional = true;
    //Allow Home, End, Shift, Caps Lock, Esc
    if (code >= 16 && code <= 20) functional = true;
    if (code == 27) functional = true;
    if (code >= 33 && code <= 40) functional = true;
    // if (code >= 44 && code <= 46) functional = true;

    // allow Ctrl shortcuts (copy, paste etc.)
    if (window.ctrl_down || metaKey) {
      if (code == 86) functional = true; // v: paste
      if (code == 67) functional = true; // c: copy
      if (code == 88) functional = true; // x: cut
      if (code == 82) functional = true; // r: reload
      if (code == 84) functional = true; // t: new tab
      if (code == 76) functional = true; // l: URL bar
      if (code == 87) functional = true; // w: close window/tab
      if (code == 81) functional = true; // q: quit
      if (code == 78) functional = true; // n: new window/tab
      if (code == 65) functional = true; // a: select all
    }

    return functional;

  }

}