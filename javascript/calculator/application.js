var val1 = 0;
var val2 = 0;
var operator = '';
var count = 0;


function display(val){
  var displayVal = document.getElementById("display-panel")
  if(displayVal.innerHTML === '0'){
		displayVal.innerHTML = ""
		displayVal.innerHTML = displayVal.innerHTML + val;
	} else if(displayVal.innerHTML.length > 10){
		flash()
  } else {
		displayVal.innerHTML = displayVal.innerHTML + val;
	};
}

//button functionality
function numButton(number){
  count += 1;
  display(number);
};

function opBtn(val){
  switch(val){
    case 'add':
      storeNum()
      flash()
      operator = 'add'
      clearDisplay()
      break;
    case 'multiply':
      storeNum()
      flash()
      operator = 'multiply'
      clearDisplay()
      break;
    case 'subtract':
      storeNum()
      flash()
      operator = 'subtract'
      clearDisplay()
      break;
    case 'divide':
      storeNum()
      flash()
      operator = 'divide'
      clearDisplay()
      break;
  }
};

function result(){
  storeNum()
  switch(operator){
    case 'add':
      clearDisplay()
      display(add(val1, val2))
      break;
    case 'multiply':
      clearDisplay()
      display(multiply(val1, val2))
      break;
    case 'subtract':
      clearDisplay()
      display(subtract(val1, val2))
      break;
    case 'divide':
      clearDisplay()
      display(divide(val1, val2))
      break;
  }
  operator = ''
};


//helpers
function flash(){
	document.getElementById("display-panel").style.display = 'none';
	setTimeout(function(){
		document.getElementById("display-panel").style.display = 'block';
	}, 100);
};

function storeNum(){
  if (count===1){
    val1 = getDisplayVal();
  }else{
    val2 = getDisplayVal();
    count = 0;
  }
};

function getDisplayVal(){
  return document.getElementById("display-panel").innerHTML;
};

function clearDisplay(){
  document.getElementById("display-panel").innerHTML = "";
}

function reset(){
  document.getElementById("display-panel").innerHTML = 0;
  val1 = 0
  val2 = 0
  count = 0
  operator = ''
}

//math operators
function add(num1, num2){
  return ((+num1) + (+num2))
};

function multiply(num1, num2){
  return (+num1 * +num2);
}

function divide(num1, num2){
  return (+num1 / +num2);
};

function subtract(num1, num2){
  return (+num1 - +num2);
}
