// Calculate Remaining Fees Field
function calculateRemainingFees(){
  
	var totalFieldValues = 0;

	for (var i = 0; i < dollarValueFields.length; i++) {
	  totalFieldValues += parseFloat(dollarValueFields[i].value);
	};

	totalMarkUp = totalFieldValues + 
	(parseFloat(numberOfBatches.value) * parseFloat(batchFee.value));

	calculateTotalPassthrough();

	var otherFeesDecimal = parseFloat(totalFees.value) - 
	interchange - 
	totalMarkUp;
	
	otherFees.value = otherFeesDecimal.toFixed(2);
	
	return otherFeesDecimal; 
};
