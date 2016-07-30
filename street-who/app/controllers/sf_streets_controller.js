'use strict';

const Nodal = require('nodal');
const SFStreet = Nodal.require('app/models/sf_street.js');

class SfStreetsController extends Nodal.Controller {

  index() {

    SFStreet.query()
      .where(this.params.query)
      .end((err, models) => {

        this.respond(err || models);

      });

  }

  show() {

    SFStreet.find(this.params.route.id, (err, model) => {

      this.respond(err || model);

    });

  }

  create() {

    SFStreet.create(this.params.body, (err, model) => {

      this.respond(err || model);

    });

  }

  update() {

    SFStreet.update(this.params.route.id, this.params.body, (err, model) => {

      this.respond(err || model);

    });

  }

  destroy() {

    SFStreet.destroy(this.params.route.id, (err, model) => {

      this.respond(err || model);

    });

  }

}

module.exports = SfStreetsController;
