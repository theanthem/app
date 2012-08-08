# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120807172208) do

  create_table "categories", :force => true do |t|
    t.string   "name",        :limit => 50, :null => false
    t.string   "short_name",  :limit => 30, :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "description"
  end

  create_table "categories_posts", :force => true do |t|
    t.integer "category_id"
    t.integer "post_id"
  end

  add_index "categories_posts", ["category_id", "post_id"], :name => "index_categories_posts_on_category_id_and_post_id"

  create_table "comments", :force => true do |t|
    t.integer  "post_id"
    t.string   "author",       :limit => 25,                    :null => false
    t.string   "author_email", :limit => 50,                    :null => false
    t.text     "content",                                       :null => false
    t.string   "status",       :limit => 25, :default => "New", :null => false
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"

  create_table "homes", :force => true do |t|
    t.string   "home_title",                    :null => false
    t.string   "home_image",                    :null => false
    t.text     "content",                       :null => false
    t.integer  "position",   :default => 0,     :null => false
    t.boolean  "visibility", :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "impressions", :force => true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], :name => "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], :name => "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], :name => "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], :name => "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], :name => "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], :name => "poly_session_index"
  add_index "impressions", ["user_id"], :name => "index_impressions_on_user_id"

  create_table "media", :force => true do |t|
    t.integer  "user_id"
    t.string   "title",                                                          :null => false
    t.string   "subtitle"
    t.string   "media_type",                                :default => "Video", :null => false
    t.string   "description",                                                    :null => false
    t.text     "content"
    t.boolean  "featured_media"
    t.string   "permalink",                                                      :null => false
    t.string   "link1_title",                :limit => 140
    t.string   "link1",                      :limit => 140
    t.string   "status",                     :limit => 20,  :default => "Draft", :null => false
    t.date     "published_at"
    t.datetime "created_at",                                                     :null => false
    t.datetime "updated_at",                                                     :null => false
    t.string   "media_thumb_file_name"
    t.string   "media_thumb_content_type"
    t.integer  "media_thumb_file_size"
    t.datetime "media_thumb_updated_at"
    t.string   "media_display_file_name"
    t.string   "media_display_content_type"
    t.integer  "media_display_file_size"
    t.datetime "media_display_updated_at"
  end

  add_index "media", ["permalink"], :name => "index_media_on_permalink"

  create_table "messages", :force => true do |t|
    t.integer  "series_id"
    t.string   "title",                                                           :null => false
    t.integer  "speaker_id"
    t.string   "scripture",                                                       :null => false
    t.string   "permalink",                                                       :null => false
    t.text     "description",                                                     :null => false
    t.date     "air_date"
    t.string   "mp3"
    t.string   "vodcast"
    t.string   "hd_video"
    t.string   "vimeo"
    t.integer  "duration"
    t.integer  "viewed"
    t.boolean  "featured_message",                           :default => false
    t.string   "status",                       :limit => 20, :default => "Draft", :null => false
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
    t.string   "message_thumb_file_name"
    t.string   "message_thumb_content_type"
    t.integer  "message_thumb_file_size"
    t.datetime "message_thumb_updated_at"
    t.string   "message_display_file_name"
    t.string   "message_display_content_type"
    t.integer  "message_display_file_size"
    t.datetime "message_display_updated_at"
  end

  add_index "messages", ["series_id"], :name => "index_messages_on_series_id"
  add_index "messages", ["speaker_id"], :name => "index_messages_on_speaker_id"

  create_table "messages_users", :force => true do |t|
    t.integer "user_id"
    t.integer "message_id"
  end

  add_index "messages_users", ["user_id", "message_id"], :name => "index_messages_users_on_user_id_and_message_id"

  create_table "news", :force => true do |t|
    t.string   "title",                                                         :null => false
    t.string   "subtitle"
    t.string   "permalink",                                                     :null => false
    t.string   "news_thumb"
    t.string   "description",                                                   :null => false
    t.boolean  "featured_news",                            :default => false
    t.text     "content"
    t.boolean  "event",                                    :default => false
    t.date     "event_date"
    t.string   "contact"
    t.string   "contact_email"
    t.string   "link1_title",               :limit => 140
    t.string   "link1",                     :limit => 140
    t.string   "link2_title",               :limit => 140
    t.string   "link2",                     :limit => 140
    t.string   "link3_title",               :limit => 140
    t.string   "link3",                     :limit => 140
    t.string   "link4_title",               :limit => 140
    t.string   "link4",                     :limit => 140
    t.integer  "position",                  :limit => 2,   :default => 0,       :null => false
    t.string   "status",                    :limit => 20,  :default => "Draft", :null => false
    t.date     "birth_date"
    t.date     "expire_date"
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
    t.string   "news_thumb_file_name"
    t.string   "news_thumb_content_type"
    t.integer  "news_thumb_file_size"
    t.datetime "news_thumb_updated_at"
    t.string   "news_display_file_name"
    t.string   "news_display_content_type"
    t.integer  "news_display_file_size"
    t.datetime "news_display_updated_at"
  end

  add_index "news", ["permalink"], :name => "index_news_on_permalink"

  create_table "pages", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name",                                                              :null => false
    t.string   "permalink",                                                         :null => false
    t.string   "template",                                   :default => "basic"
    t.integer  "position",                     :limit => 2,  :default => 0,         :null => false
    t.string   "visibility",                                 :default => "Visible"
    t.date     "published_at"
    t.string   "status",                       :limit => 20, :default => "Draft",   :null => false
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "page_thumbnail_file_name"
    t.string   "page_thumbnail_content_type"
    t.integer  "page_thumbnail_file_size"
    t.datetime "page_thumbnail_updated_at"
    t.string   "page_display_file_name"
    t.string   "page_display_content_type"
    t.integer  "page_display_file_size"
    t.datetime "page_display_updated_at"
    t.string   "page_background_file_name"
    t.string   "page_background_content_type"
    t.integer  "page_background_file_size"
    t.datetime "page_background_updated_at"
  end

  add_index "pages", ["parent_id"], :name => "index_pages_on_parent_id"
  add_index "pages", ["permalink"], :name => "index_pages_on_permalink"

  create_table "posts", :force => true do |t|
    t.string   "title",                       :limit => 100,                      :null => false
    t.integer  "user_id"
    t.string   "permalink",                   :limit => 100,                      :null => false
    t.text     "content",                                                         :null => false
    t.string   "featured_image"
    t.boolean  "featured_post",                              :default => false
    t.date     "published_at"
    t.string   "status",                      :limit => 20,  :default => "Draft", :null => false
    t.integer  "comments_count",                             :default => 0
    t.datetime "created_at",                                                      :null => false
    t.datetime "updated_at",                                                      :null => false
    t.string   "featured_image_file_name"
    t.string   "featured_image_content_type"
    t.integer  "featured_image_file_size"
    t.datetime "featured_image_updated_at"
  end

  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "section_edits", :force => true do |t|
    t.integer  "user_id"
    t.integer  "section_id"
    t.string   "summary"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "section_edits", ["user_id", "section_id"], :name => "index_section_edits_on_user_id_and_section_id"

  create_table "sections", :force => true do |t|
    t.integer  "page_id"
    t.string   "title",                           :limit => 100,                      :null => false
    t.string   "content_type",                    :limit => 20,  :default => "Text",  :null => false
    t.text     "content",                                                             :null => false
    t.string   "link1_title",                     :limit => 140
    t.string   "link1",                           :limit => 140
    t.string   "link2_title",                     :limit => 140
    t.string   "link2",                           :limit => 140
    t.string   "link3_title",                     :limit => 140
    t.string   "link3",                           :limit => 140
    t.string   "link4_title",                     :limit => 140
    t.string   "link4",                           :limit => 140
    t.integer  "position",                        :limit => 2,   :default => 0,       :null => false
    t.string   "status",                          :limit => 20,  :default => "Draft", :null => false
    t.datetime "created_at",                                                          :null => false
    t.datetime "updated_at",                                                          :null => false
    t.string   "section_display_file_name"
    t.string   "section_display_content_type"
    t.integer  "section_display_file_size"
    t.datetime "section_display_updated_at"
    t.string   "section_background_file_name"
    t.string   "section_background_content_type"
    t.integer  "section_background_file_size"
    t.datetime "section_background_updated_at"
  end

  add_index "sections", ["page_id"], :name => "index_sections_on_page_id"

  create_table "series", :force => true do |t|
    t.string   "title",                                                       :null => false
    t.string   "subtitle"
    t.string   "book"
    t.string   "permalink",                                                   :null => false
    t.text     "description"
    t.date     "start_date",                                                  :null => false
    t.date     "end_date"
    t.boolean  "featured_series",                          :default => false, :null => false
    t.boolean  "visibility",                               :default => false, :null => false
    t.integer  "messages_count",              :limit => 2, :default => 0,     :null => false
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at",                                                  :null => false
    t.string   "series_thumb_file_name"
    t.string   "series_thumb_content_type"
    t.integer  "series_thumb_file_size"
    t.datetime "series_thumb_updated_at"
    t.string   "series_display_file_name"
    t.string   "series_display_content_type"
    t.integer  "series_display_file_size"
    t.datetime "series_display_updated_at"
  end

  create_table "speakers", :force => true do |t|
    t.string   "first_name",                               :null => false
    t.string   "last_name",                                :null => false
    t.string   "title",              :default => "Pastor"
    t.string   "church"
    t.text     "bio"
    t.string   "speaker_image"
    t.string   "website"
    t.string   "twitter"
    t.integer  "messages_count",     :default => 0
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "uploads", :force => true do |t|
    t.integer  "post_id"
    t.string   "description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name",          :limit => 25,                 :null => false
    t.string   "last_name",           :limit => 40,                 :null => false
    t.string   "username",            :limit => 25,                 :null => false
    t.string   "hashed_password",     :limit => 40
    t.string   "salt",                :limit => 40
    t.string   "email",               :limit => 50,                 :null => false
    t.string   "title",               :limit => 100
    t.text     "bio",                                               :null => false
    t.integer  "access_level",        :limit => 2,   :default => 0, :null => false
    t.string   "twitter",             :limit => 50
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["username"], :name => "index_users_on_username"

  create_table "users_media", :force => true do |t|
    t.integer "user_id"
    t.integer "media_id"
  end

  add_index "users_media", ["user_id", "media_id"], :name => "index_users_media_on_user_id_and_media_id"

  create_table "users_news", :force => true do |t|
    t.integer "user_id"
    t.integer "news_id"
  end

  add_index "users_news", ["user_id", "news_id"], :name => "index_users_news_on_user_id_and_news_id"

end
