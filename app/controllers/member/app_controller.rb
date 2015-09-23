class Member::AppController < ApplicationController
  prepend_before_action :authenticate_member!
end
