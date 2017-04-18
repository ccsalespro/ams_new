//Set Total VMD Volume
function setTotalVmdVolume(){
	var totalVolume = parseFloat(vsVolume.value) + 
	parseFloat(mcVolume.value) + 
	parseFloat(dsVolume.value);

	return totalVolume;
};

// Set total VMD Transactions
function setTotalVmdTransactions(){
	var totalTransactions = parseFloat(vsTransactions.value) + 
	parseFloat(mcTransactions.value) + 
	parseFloat(dsTransactions.value);

	return totalTransactions;
};

function calculateDebitFees(ratio, volume) {
	if (parseFloat(debitVolume.value) > 0){
		if (ratio > 2 && volume <= 3000) {
			debitPerItemFee.value = 0.35;
			debitBpMarkUp.value = 10;
		} else if (ratio > 2 && volume > 3000){
			debitPerItemFee.value = 0.20;
			debitBpMarkUp.value = 0;
		} else if (volume > 5000) {
			debitPerItemFee.value = Math.max(0.06, ((ratio / 10).toFixed(2)));
			debitBpMarkUp.value = 0;
		} else {
			debitPerItemFee.value = Math.max(0.10, ((ratio / 5).toFixed(2)));
			debitBpMarkUp.value = 5;
		}
	} else {
		debitPerItemFee.value = 0;
		debitBpMarkUp.value = 0;
	}
};

function calculateAmexFees(ratio, volume) {
	if (parseFloat(amexVolume.value) > 0){
		if (ratio > 2 && volume <= 3000) {
			amexPerItemFee.value = 0.25;
			amexBpMarkUp.value = 60;
		} else if (ratio > 2 && volume > 3000){
			amexPerItemFee.value = 0.20;
			amexBpMarkUp.value = 40;
		} else if (volume > 5000) {
			amexPerItemFee.value = Math.max(0.15, ((ratio / 8).toFixed(2)));
			amexBpMarkUp.value = 25;
		} else {
			amexPerItemFee.value = 0.25;
			amexBpMarkUp.value = 60;
		}
	} else {
		amexPerItemFee.value = 0;
		amexBpMarkUp.value = 0;
	}
};

function calculateVmdFees(ratio, volume) {
	var testTransFee = (ratio / 10);
	var finalTransFee = 0;
	if (testTransFee > 0.20) {
		finalTransFee = 0.20;
	} else if (testTransFee < 0.035) {
		finalTransFee = 0.035;
	} else {
		finalTransFee = testTransFee.toFixed(2);
	};

	calculateValues();
	var remainingFees = calculateRemainingFees();
	var totalTransactions = setTotalVmdTransactions();
	var bpRemainingFees = remainingFees - (finalTransFee * totalTransactions);
	var totalVmdVolume = setTotalVmdVolume();

	var bpMarkUp = (bpRemainingFees / totalVmdVolume) * 10000;
	if (bpMarkUp > 10.1){
		bpMarkUp = Math.floor(bpMarkUp/5)*5;
	};

	setVmdFieldValues(bpMarkUp, finalTransFee);

};

//If monthly fees / other fees are zero, set to defaults.
function setCurrentOtherFees(){
	if (totalVmdVolume < 1000) {
		monthlyFees.value = 9.95;
		monthlyPciFee.value = 0;
		numberOfBatches.value = 20;
		batchFee.value = 0.30;
	} else if (totalVmdVolume < 10000) {
		monthlyFees.value = 9.95;
		monthlyPciFee.value = 9.95;
		numberOfBatches.value = 20;
		batchFee.value = 0.30;
	} else {
		monthlyFees.value = 19.95;
		monthlyPciFee.value = 9.95;
		numberOfBatches.value = 20;
		batchFee.value = 0.30;
	};

	if (debitVolume.value > 100 && debitVolume.value <= 1000) {
		monthlyDebitFee.value = 5;
	} else if (debitVolume > 1000){
		monthlyDebitFee.value = 10;
	};
};

function feesAlgorithm(){
	totalVmdVolume = setTotalVmdVolume();
	totalVmdTransactions = setTotalVmdTransactions();

	var debitRatio = calculateRatio(parseFloat(debitAvgTicket.value));
	var amexRatio = calculateRatio(parseFloat(amexAvgTicket.value));
	var vmdRatio = calculateRatio(totalVmdVolume / totalVmdTransactions);

	calculateDebitFees(debitRatio, parseFloat(debitVolume.value));
	calculateAmexFees(amexRatio, parseFloat(amexVolume.value));
	setCurrentOtherFees();
	calculateVmdFees(vmdRatio, totalVmdVolume);
	
};