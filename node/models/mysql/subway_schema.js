/**
 * subway_schema.js
 */

module.exports = (sequelize, DataTypes) => {
	const Subway = sequelize.define('Subway', {
		subway_id: {
			type: DataTypes.INTEGER(4),
			primaryKey: true
		},
		station_cd: DataTypes.STRING(4),
		station_nm: DataTypes.STRING(9),
		line_num: DataTypes.STRING(2),
		fr_code: DataTypes.STRING(6),
		lat: DataTypes.DECIMAL(10, 8),
		lng: DataTypes.DECIMAL(11, 8)
	});
	return Subway;
};