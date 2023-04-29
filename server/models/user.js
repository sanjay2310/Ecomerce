const mongoose = require('mongoose');
const userSchema = mongoose.Schema({
	name:{
		required: true,
		type: String,
		trim: true,
	},
	email:{
		required: true,
		type: String,
		trim: true,
		validate:{validator:(value) =>{
			const rex = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
		return value.match(rex);
		},
	Message: "Please enter a valid email address"
	}
		
	},
	password:{
		required: true,
		type: String,
		validate:{validator:(value) =>{
		//	const rex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[#$@!%&*?])[A-Za-z\d#$@!%&*?]{6,30}$/

		//return value.match(rex);
		},
	Message:"Minimum eight characters, at least one letter and one number"
	}
		

	},
	address:{
		type: 'string',
		default:" ",

	},
	type:{
		type: String,
		default:"user"
	},
	
	//cart
});const User = mongoose.model("User",userSchema);
module.exports = User;