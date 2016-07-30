'use strict';

const Nodal = require('nodal');

class CreateStreets extends Nodal.Migration {

  constructor(db) {
    super(db);
    this.id = 2016072903464813;
  }

  up() {

    return [
      this.createTable("streets", [])
    ];

  }

  down() {

    return [
      this.dropTable("streets")
    ];

  }

}

module.exports = CreateStreets;
