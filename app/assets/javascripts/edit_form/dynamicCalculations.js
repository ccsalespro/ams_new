function trueUpDefaultBp(remainingFees, totalVmdVolume){
	bpMarkUp = parseFloat(defaultBasisPoints.value) + 
		((remainingFees / totalVmdVolume) * 10000);
	return bpMarkUp;
};

function trueUpDefaultPerItem(remainingFees, totalVmdTransactions){
	var transFee = parseFloat(defaultPerItemFee.value) + 
		(remainingFees / totalVmdTransactions);
	return transFee;
};

function trueUpCurrentInterchange(remainingFees, currentInterchangeValue, level){

	if (remainingFees > 0 && level == "high"){
		
		while (currentInterchangeValue < currentInterchange.highFee && Math.abs(remainingFees) > 2){
			currentInterchangeValue += 1;
			remainingFees -= 1
		};
	} else if (remainingFees > 0 && level == "max"){
		
		while (currentInterchangeValue < currentInterchange.maxFee && Math.abs(remainingFees) > 2){
			currentInterchangeValue += 1;
			remainingFees -= 1
		};
	} else if (remainingFees < 0){

		while (currentInterchangeValue > currentInterchange.minFee && Math.abs(remainingFees) > 2){
			currentInterchangeValue -= 1;
			remainingFees += 1
		};
	};

	currentInterchange.value = currentInterchangeValue.toFixed(2);
	calculateTotalPassthrough();
	remainingFees = calculateRemainingFees();
	return remainingFees;
};

function trueUpDebitPerItemFee(remainingFees, debitPerItemValue, level){
	if (remainingFees > 0 && level == "high"){
		while (debitPerItemValue < debitPerItemFee.highFee && Math.abs(remainingFees) > 2){
			debitPerItemValue += 0.01;
			remainingFees -= 0.01
		};	
	} else if (remainingFees > 0 && level == "max"){
		while (debitPerItemValue < debitPerItemFee.maxFee && Math.abs(remainingFees) > 2){
			debitPerItemValue += 0.01;
			remainingFees -= 0.01
		};
	} else if (remainingFees < 0 && level == "low"){
		while (debitPerItemValue > debitPerItemFee.lowFee && Math.abs(remainingFees) > 2){
			debitPerItemValue -= 0.01;
			remainingFees += 0.01
		};
	} else if (remainingFees < 0 && level == "min"){
		while (debitPerItemValue > debitPerItemFee.minFee && Math.abs(remainingFees) > 2){
			debitPerItemValue -= 0.01;
			remainingFees += 0.01
		};
	};

	debitPerItemFee.value = debitPerItemValue.toFixed(2);
	calculateDebitValues();
	remainingFees = calculateRemainingFees();
};

function trueUpDebitBpMarkUp(remainingFees, debitBpValue, level){
	if (remainingFees > 0 && level == "high"){
		while (debitBpValue < debitBpMarkUp.highFee && Math.abs(remainingFees) > 2){
			debitBpValue += 1;
			remainingFees -= 1;
		};	
	} else if (remainingFees > 0 && level == "max"){
		while (debitBpValue < debitBpMarkUp.maxFee && Math.abs(remainingFees) > 2){
			debitBpValue += 1;
			remainingFees -= 1;
		};
	} else if (remainingFees < 0 && level == "low"){
		while (debitBpValue > debitBpMarkUp.lowFee && Math.abs(remainingFees) > 2){
			debitBpValue -= 1;
			remainingFees += 1;
		};
	} else if (remainingFees < 0 && level == "min"){
		while (debitBpValue > debitBpMarkUp.minFee && Math.abs(remainingFees) > 2){
			debitBpValue -= 1;
			remainingFees += 1;
		};
	};

	debitBpMarkUp.value = debitBpValue.toFixed(0);
	calculateDebitValues();
	remainingFees = calculateRemainingFees();
};

function trueUpAmexBpMarkUp(remainingFees, amexBpValue, level){
	if (remainingFees > 0 && level == "high"){
		while (amexBpValue < amexBpMarkUp.highFee && Math.abs(remainingFees) > 2){
			amexBpValue += 1;
			remainingFees -= 1;
		};	
	} else if (remainingFees > 0 && level == "max"){
		while (amexBpValue < amexBpMarkUp.maxFee && Math.abs(remainingFees) > 2){
			amexBpValue += 1;
			remainingFees -= 1;
		};
	} else if (remainingFees < 0 && level == "low"){
		while (amexBpValue > amexBpMarkUp.lowFee && Math.abs(remainingFees) > 2){
			amexBpValue -= 1;
			remainingFees += 1;
		};
	} else if (remainingFees < 0 && level == "min"){
		while (amexBpValue > amexBpMarkUp.minFee && Math.abs(remainingFees) > 2){
			amexBpValue -= 1;
			remainingFees += 1;
		};
	}

	amexBpMarkUp.value = amexBpValue.toFixed(0);
	calculateAmexValues();
	remainingFees = calculateRemainingFees();
};

function trueUpAmexPerItemFee(remainingFees, amexPerItemValue, level){
	if (remainingFees > 0 && level == "high"){
		while (amexPerItemValue < amexPerItemFee.highFee && Math.abs(remainingFees) > 2){
			amexPerItemValue += 0.01;
			remainingFees -= 0.01
		};	
	} else if (remainingFees > 0 && level == "max"){
		while (amexPerItemValue < amexPerItemFee.maxFee && Math.abs(remainingFees) > 2){
			amexPerItemValue += 0.01;
			remainingFees -= 0.01
		};
	} else if (remainingFees < 0 && level == "low"){
		while (amexPerItemValue > amexPerItemFee.lowFee && Math.abs(remainingFees) > 2){
			amexPerItemValue -= 0.01;
			remainingFees += 0.01
		};
	} else if (remainingFees < 0 && level == "min"){
		while (amexPerItemValue > amexPerItemFee.minFee && Math.abs(remainingFees) > 2){
			amexPerItemValue -= 0.01;
			remainingFees += 0.01
		};
	};

	amexPerItemFee.value = amexPerItemValue.toFixed(2);
	calculateAmexValues();
	remainingFees = calculateRemainingFees();
};

function trueUpRemainingFees(){

	remainingFees = calculateRemainingFees();
	totalVmdVolume = setTotalVmdVolume();
	totalVmdTransactions = setTotalVmdTransactions();

	var debitRatio = calculateRatio(parseFloat(debitAvgTicket.value));
	var amexRatio = calculateRatio(parseFloat(amexAvgTicket.value));
	var vmdRatio = calculateRatio(totalVmdVolume / totalVmdTransactions);
	var transFee = parseFloat(defaultPerItemFee.value);
	var bpMarkUp = parseFloat(defaultBasisPoints.value);
	var currentInterchangeValue = parseFloat(currentInterchange.value);

	var i = 0;
	while (i < 20 && Math.abs(remainingFees) > 2){ 
		if (remainingFees > 0){
			if (defaultBasisPoints.locked != true && defaultBasisPoints.level != "high"){
				var bpMarkUp = trueUpDefaultBp(remainingFees, totalVmdVolume);
			} else if (defaultPerItemFee.locked != true && defaultPerItemFee.level != "high"){
				var transFee = trueUpDefaultPerItem(remainingFees, totalVmdTransactions);
			} else if (currentInterchange.locked != true && currentInterchangeValue < currentInterchange.highFee){
				var level = "high";
				trueUpCurrentInterchange(remainingFees, currentInterchangeValue, level);
			} else if (debitPerItemFee.locked != true && parseFloat(debitPerItemFee.value) < debitPerItemFee.highFee){
				var level = "high";
				var debitPerItemValue = parseFloat(debitPerItemFee.value);
				trueUpDebitPerItemFee(remainingFees, debitPerItemValue, level);
			} else if (debitBpMarkUp.locked != true && parseFloat(debitBpMarkUp.value) < debitBpMarkUp.highFee){
				var level = "high";
				var debitBpValue = parseFloat(debitBpMarkUp.value);
				trueUpDebitBpMarkUp(remainingFees, debitBpValue, level);
			} else if (amexBpMarkUp.locked != true && parseFloat(amexBpMarkUp.value) < amexBpMarkUp.highFee){
				var level = "high";
				var amexBpValue = parseFloat(amexBpMarkUp.value);
				trueUpAmexBpMarkUp(remainingFees, amexBpValue, level);
			} else if (amexPerItemFee.locked != true && parseFloat(amexPerItemFee.value) < amexPerItemFee.highFee){
				var level = "high";
				var amexPerItemValue = parseFloat(amexPerItemFee.value);
				trueUpAmexPerItemFee(remainingFees, amexPerItemValue, level);
			} else if (currentInterchange.locked != true && currentInterchangeValue < currentInterchange.maxFee){
				var level = "max";
				trueUpCurrentInterchange(remainingFees, currentInterchangeValue, level);
			} else if (debitPerItemFee.locked != true && parseFloat(debitPerItemFee.value) < debitPerItemFee.maxFee){
				var level = "max";
				var debitPerItemValue = parseFloat(debitPerItemFee.value);
				trueUpDebitPerItemFee(remainingFees, debitPerItemValue, level);
			} else if (debitBpMarkUp.locked != true && parseFloat(debitBpMarkUp.value) < debitBpMarkUp.maxFee){
				var level = "max";
				var debitBpValue = parseFloat(debitBpMarkUp.value);
				trueUpDebitBpMarkUp(remainingFees, debitBpValue, level);
			} else if (amexBpMarkUp.locked != true && parseFloat(amexBpMarkUp.value) < amexBpMarkUp.maxFee){
				var level = "max";
				var amexBpValue = parseFloat(amexBpMarkUp.value);
				trueUpAmexBpMarkUp(remainingFees, amexBpValue, level);
			} else if (amexPerItemFee.locked != true && parseFloat(amexPerItemFee.value) < amexPerItemFee.maxFee){
				var level = "max";
				var amexPerItemValue = parseFloat(amexPerItemFee.value);
				trueUpAmexPerItemFee(remainingFees, amexPerItemValue, level);
			}

		} else if (remainingFees < 0) {
			if (defaultBasisPoints.locked != true && defaultBasisPoints.level != "low"){
				var bpMarkUp = trueUpDefaultBp(remainingFees, totalVmdVolume);
			} else if (defaultPerItemFee.locked != true && defaultPerItemFee.level != "low"){
				var transFee = trueUpDefaultPerItem(remainingFees, totalVmdTransactions);
			} else if (currentInterchange.locked != true && currentInterchangeValue > currentInterchange.minFee){
				var level = "min";
				trueUpCurrentInterchange(remainingFees, currentInterchangeValue, level);
			} else if (debitPerItemFee.locked != true && parseFloat(debitPerItemFee.value) > debitPerItemFee.lowFee){
				var level = "low";
				var debitPerItemValue = parseFloat(debitPerItemFee.value);
				trueUpDebitPerItemFee(remainingFees, debitPerItemValue, level);
			} else if (debitBpMarkUp.locked != true && parseFloat(debitBpMarkUp.value) > debitBpMarkUp.minFee){
				var level = "min";
				var debitBpValue = parseFloat(debitBpMarkUp.value);
				trueUpDebitBpMarkUp(remainingFees, debitBpValue, level);
			} else if (amexBpMarkUp.locked != true && parseFloat(amexBpMarkUp.value) > amexBpMarkUp.lowFee){
				var level = "low";
				var amexBpValue = parseFloat(amexBpMarkUp.value);
				trueUpAmexBpMarkUp(remainingFees, amexBpValue, level);
			} else if (amexPerItemFee.locked != true && parseFloat(amexPerItemFee.value) > amexPerItemFee.lowFee){
				var level = "low";
				var amexPerItemValue = parseFloat(amexPerItemFee.value);
				trueUpAmexPerItemFee(remainingFees, amexPerItemValue, level);
			} else if (debitPerItemFee.locked != true && parseFloat(debitPerItemFee.value) > debitPerItemFee.minFee){
				var level = "min";
				var debitPerItemValue = parseFloat(debitPerItemFee.value);
				trueUpDebitPerItemFee(remainingFees, debitPerItemValue, level);
			} else if (amexBpMarkUp.locked != true && parseFloat(amexBpMarkUp.value) > amexBpMarkUp.minFee){
				var level = "min";
				var amexBpValue = parseFloat(amexBpMarkUp.value);
				trueUpAmexBpMarkUp(remainingFees, amexBpValue, level);
			} else if (amexPerItemFee.locked != true && parseFloat(amexPerItemFee.value) > amexPerItemFee.minFee){
				var level = "min";
				var amexPerItemValue = parseFloat(amexPerItemFee.value);
				trueUpAmexPerItemFee(remainingFees, amexPerItemValue, level);
			}
		} 
	
	setVmdFieldValues(bpMarkUp, transFee);
	currentInterchangeValue = parseFloat(currentInterchange.value);	
	remainingFees = calculateRemainingFees();
	i += 1;
	}

	remainingFees = calculateRemainingFees();
	var remainingFeesRatio = remainingFees / totalVmdVolume;
	if (remainingFees < 0.01){
		adjustRemainingToInterchange();
	};
	generateAlertMessage(parseFloat(defaultPerItemFee.value), parseFloat(defaultBasisPoints.value), totalVmdVolume);
	
};