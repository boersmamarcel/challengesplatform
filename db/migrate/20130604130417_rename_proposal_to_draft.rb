class RenameProposalToDraft < ActiveRecord::Migration
  def up
    Challenge.where(:state => 'proposal').all.each do |c|
      c.update_attribute :state, 'draft'
    end
  end

  def down
    Challenge.where(:state => 'draft').all.each do |c|
      c.update_attribute :state, 'proposal'
    end
  end
end
