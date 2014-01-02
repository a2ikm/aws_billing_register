# coding: utf-8
require "active_record/fixtures"

FIXTURES_DIR = File.expand_path("../fixtures", __FILE__)

fixtures =
  if ENV["FIXTURES"]
    ENV["FIXTURES"].split(",").map do |f|
      f = "#{f}.yml" unless f =~ /\.yml$/
      File.expand_path(f, FIXTURES_DIR)
    end
  else
    Dir.glob("#{FIXTURES_DIR}/*.yml")
  end


fixtures.each do |yml_path|
  puts "Loading #{yml_path.sub("#{FIXTURES_DIR}/", "")}"

  yml_name = File.basename(yml_path, ".yml")
  yml_class = yml_name.classify

  conn = ActiveRecord::Base.connection
  fixtures = ActiveRecord::FixtureSet.new(conn, yml_name, yml_class, "#{File.dirname(yml_path)}/#{yml_name}")
  fixtures.table_rows.each do |table_name, rows|
    rows.each do |row|
      conn.delete "DELETE FROM #{table_name} WHERE id = #{row["id"]}"
      conn.insert_fixture row, table_name
    end
  end
end

