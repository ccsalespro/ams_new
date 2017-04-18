function changeTotalPassthrough(){
	var difference = parseFloat(totalPassthroughTop.value) - parseFloat(totalPassthrough.value);
	currentInterchange.value = (parseFloat(currentInterchange.value) + difference).toFixed(2);
	calculateTotalPassthrough();
	totalPassthroughTop.value = totalPassthrough.value;
};