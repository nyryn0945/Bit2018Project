const fs = require('fs');
const path = require('path');
const basename = path.join(__dirname, 'mysql');
const config = require('../config/config.js');
const Sequelize = require('sequelize');
var db = {};

const sequelize = new Sequelize(config.mysqlUri, {
	logging: false,
	operatorsAliases: false,
	define: {
		underscored: false,
		freezeTableName: true,
		timestamps: false
	}
});

fs.readdirSync(basename)
.filter(file => {
	return (file.indexOf('.') !== 0) && (file.slice(-3) === '.js');
})
.forEach(file => {
	var model = sequelize['import'](path.join(basename, file));
	db[model.name] = model;
});

Object.keys(db).forEach(modelName => {
	if (db[modelName].associate) {
		db[modelName].associate(db);
	}
});

db.sequelize = sequelize;
db.Sequelize = Sequelize;

module.exports = db;