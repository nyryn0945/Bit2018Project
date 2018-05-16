const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const TaxiSchema = new Schema({
	socketId: {type: String, index: true, unique: true},
	departure: {
		name: String,
		loc: {
			type: {type: String, default: 'Point'},
			coordinates: {type: [Number], index: '2dsphere'}
		}
	},
	arrival: {
		name: String,
		loc: {
			type: {type: String, default: 'Point'},
			coordinates: {type: [Number], index: '2dsphere'}
		}
	}
});


/* ===================
   static, method 추가
====================*/

// DB에 입력
TaxiSchema.statics.add = function(req) {
	const request = new this(req);
    return request.save();
};

// DB에서 찾기
TaxiSchema.statics.search = function(type, req) {
	var obj = {'socketId': {$ne: req.socketId}};
	if (type == 'd') {
		obj['departure.loc.coordinates'] = {
			$near: {
				$geometry: {type: "Point", coordinates: req.departure.loc.coordinates},
				$maxDistance: 1000
			}
		};
	}
	else {
		obj['arrival.loc.coordinates'] = {
			$near: {
				$geometry: {type: "Point", coordinates: req.arrival.loc.coordinates},
				$maxDistance: 1000
			}
		};
	}
	return this.find(obj).exec();
};

// DB에서 택시idx로 삭제
TaxiSchema.statics.deleteById = function(id) {
	return this.findByIdAndRemove(id).exec();
};

// DB에서 소켓아이디로 삭제
TaxiSchema.statics.deleteBySocketId = function(socketId) {
	return this.findOneAndRemove({socketId: socketId}).exec();
};

// 모델을 위한 스키마 등록
module.exports = mongoose.model('taxi', TaxiSchema);