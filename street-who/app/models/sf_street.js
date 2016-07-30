'use strict';

const Nodal = require('nodal');

class SFStreet extends Nodal.Model {}

SFStreet.setDatabase(Nodal.require('db/main.js'));
SFStreet.setSchema(Nodal.my.Schema.models.SFStreet);

module.exports = SFStreet;
