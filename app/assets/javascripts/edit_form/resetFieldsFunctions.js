// Reset All Fields
function resetAllFields() {
	resetVsValues();
	resetMcValues();
	resetDsValues();
	resetAmexValues();
	resetDebitValues();
};


//Visa Functions.
function resetVsValues() {
	vsTransactions.value = statementVsTransactions.toFixed(0);
	vsVolume.value = statementVsVolume.toFixed(2);
	vsAvgTicket.value = calculateAvgTicket(parseFloat(vsVolume.value), parseFloat(vsTransactions.value));
	vsBpMarkUp.value = parseFloat(defaultBasisPoints.value);
	vsPerItemFee.value = parseFloat(defaultPerItemFee.value);
	vsTotalPerItemFees.value = calculatePerItemFees(parseFloat(vsTransactions.value), parseFloat(vsPerItemFee.value));
	vsTotalMarkUpFees.value = calculateMarkUpFees(parseFloat(vsBpMarkUp.value), parseFloat(vsVolume.value));
};

//Mastercard Functions.
function resetMcValues() {
	mcTransactions.value = statementMcTransactions.toFixed(0);
	mcVolume.value = statementMcVolume.toFixed(2);
	mcAvgTicket.value = calculateAvgTicket(parseFloat(mcVolume.value), parseFloat(mcTransactions.value));
	mcBpMarkUp.value = parseFloat(defaultBasisPoints.value);
	mcPerItemFee.value = parseFloat(defaultPerItemFee.value);
	mcTotalPerItemFees.value = calculatePerItemFees(parseFloat(mcTransactions.value), parseFloat(mcPerItemFee.value));
	mcTotalMarkUpFees.value = calculateMarkUpFees(parseFloat(mcBpMarkUp.value), parseFloat(mcVolume.value));
};

//Discover Functions.
function resetDsValues() {
	dsTransactions.value = statementDsTransactions.toFixed(0);
	dsVolume.value = statementDsVolume.toFixed(2);
	dsAvgTicket.value = calculateAvgTicket(parseFloat(dsVolume.value), parseFloat(dsTransactions.value));
	dsBpMarkUp.value = parseFloat(defaultBasisPoints.value);
	dsPerItemFee.value = parseFloat(defaultPerItemFee.value);
	dsTotalPerItemFees.value = calculatePerItemFees(parseFloat(dsTransactions.value), parseFloat(dsPerItemFee.value));
	dsTotalMarkUpFees.value = calculateMarkUpFees(parseFloat(dsBpMarkUp.value), parseFloat(dsVolume.value));
};

//Amex Functions.
function resetAmexValues() {
	amexTransactions.value = statementAmexTransactions.toFixed(0);
	amexVolume.value = statementAmexVolume.toFixed(2);
	amexAvgTicket.value = calculateAvgTicket(parseFloat(amexVolume.value), parseFloat(amexTransactions.value));
	amexTotalPerItemFees.value = calculatePerItemFees(parseFloat(amexTransactions.value), parseFloat(amexPerItemFee.value));
	amexTotalMarkUpFees.value = calculateMarkUpFees(parseFloat(amexBpMarkUp.value), parseFloat(amexVolume.value));
};

//Debit Functions.
function resetDebitValues() {
	debitTransactions.value = statementDebitTransactions.toFixed(0);
	debitVolume.value = statementDebitVolume.toFixed(2);
	debitAvgTicket.value = calculateAvgTicket(parseFloat(debitVolume.value), parseFloat(debitTransactions.value));
	debitTotalPerItemFees.value = calculatePerItemFees(parseFloat(debitTransactions.value), parseFloat(debitPerItemFee.value));
	debitTotalMarkUpFees.value = calculateMarkUpFees(parseFloat(debitBpMarkUp.value), parseFloat(debitVolume.value));
};