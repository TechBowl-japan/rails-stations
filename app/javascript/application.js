import Rails from "@rails/ujs";
import "@hotwired/turbo-rails";
import * as ActiveStorage from "@rails/activestorage";
import "./channels";

Rails.start();
ActiveStorage.start();
