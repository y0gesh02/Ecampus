# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_10_13_091522) do
  create_table "campus_applications", force: :cascade do |t|
    t.string "contact_information", null: false
    t.string "status", default: "Application Submitted"
    t.string "applicant_id", null: false
    t.integer "user_id", null: false
    t.integer "campus_drive_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campus_drive_id"], name: "index_campus_applications_on_campus_drive_id"
    t.index ["user_id"], name: "index_campus_applications_on_user_id"
  end

  create_table "campus_drives", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.text "description"
    t.datetime "start_date", precision: nil
    t.datetime "end_date", precision: nil
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name", default: "logo1.png"
    t.integer "test_id"
    t.string "eligible_year"
    t.string "slug"
    t.index ["test_id"], name: "index_campus_drives_on_test_id"
    t.index ["user_id"], name: "index_campus_drives_on_user_id"
  end

  create_table "job_applications", force: :cascade do |t|
    t.string "contact_information", null: false
    t.string "status", default: "Application Submitted"
    t.string "applicant_id", null: false
    t.integer "user_id", null: false
    t.integer "job_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_job_applications_on_job_id"
    t.index ["user_id"], name: "index_job_applications_on_user_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "company_name"
    t.string "contact_info"
    t.string "salary"
    t.integer "user_id", null: false
    t.string "status", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_jobs_on_user_id"
  end

  create_table "papers", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "total_marks"
    t.integer "duration_in_minutes"
    t.integer "passing_marks"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_papers_on_user_id"
  end

  create_table "papers_questions", id: false, force: :cascade do |t|
    t.integer "paper_id", null: false
    t.integer "question_id", null: false
  end

  create_table "papers_tests", id: false, force: :cascade do |t|
    t.integer "test_id", null: false
    t.integer "paper_id", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.text "question", null: false
    t.string "question_type", default: "objective", null: false
    t.json "options", default: []
    t.text "correct_answer"
    t.text "answer"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "reports", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "question_id", null: false
    t.integer "paper_id", null: false
    t.text "response_text"
    t.text "response_choice"
    t.integer "test_attempt_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["paper_id"], name: "index_reports_on_paper_id"
    t.index ["question_id"], name: "index_reports_on_question_id"
    t.index ["test_attempt_id"], name: "index_reports_on_test_attempt_id"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "test_attempts", force: :cascade do |t|
    t.integer "test_id", null: false
    t.integer "campus_drive_id"
    t.integer "job_id"
    t.datetime "started_at"
    t.datetime "submitted_at"
    t.integer "total_score"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campus_drive_id"], name: "index_test_attempts_on_campus_drive_id"
    t.index ["job_id"], name: "index_test_attempts_on_job_id"
    t.index ["test_id"], name: "index_test_attempts_on_test_id"
    t.index ["user_id"], name: "index_test_attempts_on_user_id"
  end

  create_table "tests", force: :cascade do |t|
    t.string "name"
    t.text "details"
    t.integer "total_time"
    t.integer "duration_in_minutes"
    t.integer "passing_marks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_tests_on_user_id"
  end

  create_table "user_reports", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "test_attempt_id", null: false
    t.integer "total_score"
    t.string "campus_drive"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_attempt_id"], name: "index_user_reports_on_test_attempt_id"
    t.index ["user_id"], name: "index_user_reports_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "role"
    t.string "otp"
    t.datetime "otp_sent_at"
    t.string "company_name"
    t.string "college_name"
    t.string "course_year", default: "1st Year"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "campus_applications", "campus_drives", column: "campus_drive_id"
  add_foreign_key "campus_applications", "users"
  add_foreign_key "campus_drives", "tests"
  add_foreign_key "campus_drives", "users"
  add_foreign_key "job_applications", "jobs"
  add_foreign_key "job_applications", "users"
  add_foreign_key "jobs", "users"
  add_foreign_key "papers", "users"
  add_foreign_key "questions", "users"
  add_foreign_key "reports", "papers"
  add_foreign_key "reports", "questions"
  add_foreign_key "reports", "test_attempts"
  add_foreign_key "reports", "users"
  add_foreign_key "test_attempts", "campus_drives", column: "campus_drive_id"
  add_foreign_key "test_attempts", "jobs"
  add_foreign_key "test_attempts", "tests"
  add_foreign_key "test_attempts", "users"
  add_foreign_key "tests", "users"
  add_foreign_key "user_reports", "test_attempts"
  add_foreign_key "user_reports", "users"
end
