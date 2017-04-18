function setVmdFieldValues(bpMarkUp, transFee){
	var newTransFee = parseFloat(transFee).toFixed(2);
	var newBpMarkUp = parseFloat(bpMarkUp).toFixed(0);

	defaultPerItemFee.value = newTransFee;
	defaultBasisPoints.value = newBpMarkUp

	vsBpMarkUp.value = newBpMarkUp
	mcBpMarkUp.value = newBpMarkUp
	dsBpMarkUp.value = newBpMarkUp

	vsPerItemFee.value = newTransFee;
	mcPerItemFee.value = newTransFee;
	dsPerItemFee.value = newTransFee;

	calculateValues();
};