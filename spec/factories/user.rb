FactoryBot.define do
  factory :user do
    nickname              {"abe"}
    email                 {"ssss@grid.man"}
    password              {"audeen1925"}
    password_confirmation {password}
    first_name            {"鵜野"}
    first_name_reading    {"ウノ"}
    last_name             {"古城戸"}
    last_name_reading     {"フルキド"}
    birthday              {"2020-01-01"}
  end
end