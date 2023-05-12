const express = require ("express");
const adminRouter = express.Router();
// Creating an Admin Middleware

const admin = require("../middleware/admin");
const Product = require("../models/product");

// Add product
adminRouter.post("/admin/add-products",admin,async(req,res)=> {
	try{
		const {name,description,images,quantity,price,category}= req.body;
		let product = new Product({
			name,
                        description,
                        images,
                        quantity,
                        price,
			category
		});
		product = await product.save();
	}catch(e){
		res.status(500).json({error:e.message});
	}
});
module.exports = adminRouter;