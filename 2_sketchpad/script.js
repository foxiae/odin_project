$(document).ready(function(){
	/*for (var x = 0; x < 256; x++){
		$('.container').append('<div></div>');
	}*/
	createGrid(20);
});


function createGrid(num){
	var dim = (600 - num * 2) / num;
	var block_color = document.querySelector("div div");

	for (var i = 0; i < num*num; i++){
		$('<div />', {class: 'block',
			width: dim + 'px',
			height: dim + 'px'
		}).appendTo('.container');
	};

	$("div div").hover(function(){
		var r = 0;
		var g = Math.floor((Math.random() * 254) + 120);
		var b = Math.floor((Math.random() * 254) + 100);
		$(this).css("background-color", 'rgb(' + r + ',' + g + ',' + b + ')');
	});
	
	$('button').on('click', function(){
		$('div div').css("background-color", "white");
	})

}




function createGrid(num) {
	$('.block').remove();
	var dim = (600 - num * 2) / num;
	for (var i=0; i<num*num; i++) {
		$('<div />', {class: 'block',
			width: dim + 'px',
			height: dim + 'px'
		}).appendTo('#screen');
	};
	$('.block').hover(function(){
		$(this).removeClass('block_light');
		$(this).addClass('block_dark');
	}, function(e) {
		if (e.ctrlKey) {
			$(this).removeClass('block_dark');
			$(this).removeClass('block_light');
		} else if (e.which == 1) {
			$(this).removeClass('block_dark');
			$(this).addClass('block_light');
		}
	});
}

function chooseSize() {
	input = prompt("Please choose a value from 1 to 100: ");
	if (isNaN(input)) {
		alert("Not a valid choice.");
		chooseSize();
	} else if (input < 1 || input > 100) {
		alert("Choice outside the given range.");
		chooseSize();
	} else {
		choice = input;
		createGrid(choice);
	};	
}

function clearAll() {
	decision = confirm("Clear the whole screen?");
	if (decision) {
		$('.block').removeClass('block_dark');
		$('.block').removeClass('block_light');
	};
} 
*/