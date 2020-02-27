class Pokemon
    attr_accessor :type, :name
    attr_reader :id, :db

    def initialize(id: nil, name:, type:, db:)
        @id = id 
        @name = name
        @type = type
        @db = db
    end

    def self.save(name_input, type_input, db_input)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?);
        SQL

        db_input.execute(sql, name_input, type_input)

        @id = db_input.execute(
            "SELECT last_insert_rowid() FROM pokemon"
        )
    end

    def self.find(id, db_input)
        result = db_input.execute(
            "SELECT * FROM pokemon WHERE id = ? LIMIT 1",
            id
        )[0]

        Pokemon.new(id: result[0], name: result[1], type: result[2], db: db_input)
    end
end
