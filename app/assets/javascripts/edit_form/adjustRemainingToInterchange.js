function adjustRemainingToInterchange(){
	var remainingFees = calculateRemainingFees();
	var interchangeValue = parseFloat(currentInterchange.value);
	currentInterchange.value = (interchangeValue + parseFloat(remainingFees)).toFixed(2);
	calculateRemainingFees();
};