'use strict';

const Nodal = require('nodal');

class CreateSfStreets extends Nodal.Migration {

  constructor(db) {
    super(db);
    this.id = 2016072903481476;
  }

  up() {

    return [
      this.createTable("sf_streets", [{"name":"name","type":"string"},{"name":"info","type":"string"}])
    ];

  }

  down() {

    return [
      this.dropTable("sf_streets")
    ];

  }

}

module.exports = CreateSfStreets;
