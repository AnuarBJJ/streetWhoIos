'use strict';

const Nodal = require('nodal');

class Street extends Nodal.Model {}

Street.setDatabase(Nodal.require('db/main.js'));
Street.setSchema(Nodal.my.Schema.models.Street);

module.exports = Street;
