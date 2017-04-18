function generateAlertMessage(currentPerItemFee, currentBpMarkUp, totalVmdVolume){
	if (currentPerItemFee < 0.01){
		defaultPerItemFee.level = "low"
		$(".fee-alert").addClass("hidden");
		$("#feeAlertFour").removeClass("hidden");
	} else if (currentPerItemFee < 0.03 && totalVmdVolume < 100000){
		defaultPerItemFee.level = "low"
		defaultBasisPoints.level = "low"
		$(".fee-alert").addClass("hidden");
		$("#feeAlertThree").removeClass("hidden");
	} else if (currentPerItemFee < 0.03){
		defaultPerItemFee.level = "low"
		defaultBasisPoints.level = "low"
		$(".fee-alert").addClass("hidden");
		$("#feeAlertTwo").removeClass("hidden");
	} else if (currentPerItemFee < 0.05 && totalVmdVolume < 50000){
		defaultPerItemFee.level = "low"
		defaultBasisPoints.level = "low"
		$(".fee-alert").addClass("hidden");
		$("#feeAlertThree").removeClass("hidden");
	} else if (currentPerItemFee < 0.05){
		defaultPerItemFee.level = "low"
		defaultBasisPoints.level = "low"
		$(".fee-alert").addClass("hidden");
		$("#feeAlertTwo").removeClass("hidden");
	} else if (currentBpMarkUp > 150){
		defaultPerItemFee.level = "high"
		defaultBasisPoints.level = "high"
		$(".fee-alert").addClass("hidden");
		$("#feeAlertSeven").removeClass("hidden");
	} else if (currentBpMarkUp > 100 && totalVmdVolume > 10000){
		defaultPerItemFee.level = "high"
		defaultBasisPoints.level = "high"
		$(".fee-alert").addClass("hidden");
		$("#feeAlertSix").removeClass("hidden");
	} else if (currentBpMarkUp > 100 && totalVmdVolume > 5000){
		defaultPerItemFee.level = "high"
		defaultBasisPoints.level = "high"
		$(".fee-alert").addClass("hidden");
		$("#feeAlertFive").removeClass("hidden");
	};
};