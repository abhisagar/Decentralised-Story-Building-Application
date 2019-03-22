var Story = artifacts.require("./Story.sol");
var app;
Story.deployed().then(function(instance) {
 app = instance 
	console.log(app.candidate())

})

