number_1 = 0
number_2 = 0
action = ""

count = 0


function add(a,b){
	return (+a + +b);
}

function multiply(a,b){
	return (+a * +b).toFixed(2);
}

function divide(a,b){
	return (+a / +b).toFixed(2);
}

function subtract(a,b){
	return (+a - +b);
}

function reset(){
	document.getElementById("display-panel").innerHTML = 0;
	number_1 = 0;
	number_2 = 0;
	count = 0
 };

 function clear_display(){
	document.getElementById("display-panel").innerHTML = "";
 };


function display(val){
	var display_val = document.getElementById("display-panel")
	if( count === 1){
		display_val.innerHTML = ""
		display_val.innerHTML = display_val.innerHTML + val;
	} else if(count > 10){
		flash()
	} else {
		display_val.innerHTML = display_val.innerHTML + val;
	};
	check_input();
};


function click_button(number){
	if(number_1.length != 0 && count == 0){
		clear_display();
		display(number);
		count += 1
	} else {
		count += 1
		display(number);

	}
};


function operations(val){
	if(val === "pos-neg"){
		var num = get_display_value();
		document.getElementById("display-panel").innerHTML = num =- num;
	};

	if(val === 'percentage'){
		var num = get_display_value();
		document.getElementById("display-panel").innerHTML = num / 100;
	};

	if(val === 'divide'){
		store_numbers();
		flash();
		apply_operation()
			action = "divide"
	};

	if(val === 'multiply') {
		store_numbers();
		flash();
		apply_operation();
		action = "multiply"
	};

	if(val === 'subtract') {
		store_numbers();
		flash();
		apply_operation();
		action = "subtract"
	};

	if(val === 'add') {
		store_numbers();
		flash();
		apply_operation()
		action = "add"
	};

	if(val === 'equals') {
		result()
	};
};


function store_numbers(){
	if(number_1  == 0){
		number_1 = (get_display_value());
		count = 0;
	} else{
		number_2 = (get_display_value());
		count = 0
	}
};

function result(){
	store_numbers()
	if (action === "divide"){
		clear_display()
		display(divide(number_1, number_2))
	}

	if (action === "add"){
		clear_display()
		display(add(number_1, number_2))
	}

	if (action === "multiply"){
		clear_display()
		display(multiply(number_1, number_2))
	}

	if (action === "subtract"){
		clear_display()
		display(subtract(number_1, number_2))
	}
}


function clear_numbers(){
	number_1 = 0
	number_2 = 0;
}

function apply_operation(){
	if (number_1 != 0 && number_2 != 0){
		result();
		number_1 = get_display_value()
		number_2 = 0
		count = 0

	}
}





function flash(){
	document.getElementById("display-panel").style.display = 'none';
	setTimeout(function(){
		document.getElementById("display-panel").style.display = 'block';
	}, 100);
};

function get_display_value(){
	return document.getElementById("display-panel").innerHTML;
};

function check_input(){
	if(get_display_value() == 80085){
		alert("now now brown cow")
	};
};
