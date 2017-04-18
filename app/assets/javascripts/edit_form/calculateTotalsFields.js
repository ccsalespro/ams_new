
// Calculate All Values
function calculateValues(){
	calculateVsValues();
	calculateMcValues();
	calculateDsValues();
	calculateAmexValues();
	calculateDebitValues();
};

function calculateVsValues(){
	vsTotalPerItemFees.value = calculatePerItemFees(parseFloat(vsTransactions.value), parseFloat(vsPerItemFee.value));
	vsTotalMarkUpFees.value = calculateMarkUpFees(parseFloat(vsBpMarkUp.value), parseFloat(vsVolume.value));
};

function calculateMcValues(){
	mcTotalPerItemFees.value = calculatePerItemFees(parseFloat(mcTransactions.value), parseFloat(mcPerItemFee.value));
	mcTotalMarkUpFees.value = calculateMarkUpFees(parseFloat(mcBpMarkUp.value), parseFloat(mcVolume.value));
};

function calculateDsValues(){
	dsTotalPerItemFees.value = calculatePerItemFees(parseFloat(dsTransactions.value), parseFloat(dsPerItemFee.value));
	dsTotalMarkUpFees.value = calculateMarkUpFees(parseFloat(dsBpMarkUp.value), parseFloat(dsVolume.value));
};

function calculateAmexValues(){
	amexTotalPerItemFees.value = calculatePerItemFees(parseFloat(amexTransactions.value), parseFloat(amexPerItemFee.value));
	amexTotalMarkUpFees.value = calculateMarkUpFees(parseFloat(amexBpMarkUp.value), parseFloat(amexVolume.value));
};

function calculateDebitValues(){
	debitTotalPerItemFees.value = calculatePerItemFees(parseFloat(debitTransactions.value), parseFloat(debitPerItemFee.value));
	debitTotalMarkUpFees.value = calculateMarkUpFees(parseFloat(debitBpMarkUp.value), parseFloat(debitVolume.value));
};