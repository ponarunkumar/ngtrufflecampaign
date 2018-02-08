var angular = require('angular');

var truffleContract = require('truffle-contract');
var campaignJson = require("../../build/contracts/Campaign.json");
var Campaign = truffleContract(campaignJson);

var app = angular.module('campaignApp', []);

app.config(function($locationProvider)){
	$locationProvider.html5Mode({
		enabled: true,
		requireBase: false
	});
});

app.controller("campaignController",
		['$scope', '$location', '$http', '$q', '$window', '$timeout', 
			function($scope, $location, $http, $q, $window, $timeout){
				Campaign.deployed()
					.then(function(_instance){
						$scope.contract = _instance;
						console.log("The Contract:", $scope.contract);
					});
			}]);
