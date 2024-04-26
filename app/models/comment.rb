# frozen_string_literal: true

class Comment < ApplicationRecord
  OLDER_COMMENT_PER_PAGE = 2

  belongs_to :user
  belongs_to :commentable, polymorphic: true, counter_cache: :comments_count
  belongs_to :parent, optional: true, class_name: "Comment"
  belongs_to :root_node, optional: true, class_name: "Comment"

  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy, inverse_of: :parent
  has_many :nodes, class_name: "Comment", foreign_key: :root_node_id, dependent: :destroy, inverse_of: :root_node
  has_rich_text :content

  validates :content, presence: true

  after_create :update_root_node_id
  after_save :touch_commentable_for_recent_comments, :touch_last_updated_at

  delegate :id, :name, :avatar, to: :user, prefix: :creator

  def creator?(curr_user)
    creator_id == curr_user.id
  end

  def no_replies?
    replies.blank?
  end

  def self.order_replies_tree
    includes(:replies).reorder("comments.updated_at ASC").references(:replies)
  end

  def self.load_associations
    includes(:rich_text_content, user: [avatar_attachment: :blob],
                                 replies: [:rich_text_content, { user: [avatar_attachment: :blob] }])
  end

  def self.order_with_associations
    load_associations.order(created_at: :asc)
  end

  def touch_last_updated_at
    update_column(:last_updated_at, Time.zone.now)
  end

  private

  def touch_commentable_for_recent_comments
    touch_parents

    commentable.touch_last_updated_at
  end

  def touch_parents
    return unless parent

    parent[:root_node_id].present? ? grand_parent : parent.touch_last_updated_at
  end

  def grand_parent
    root_node.parent&.touch_last_updated_at
  end

  def update_root_node_id
    update!(root_node_id:)
  end

  def root_node_id
    return unless parent

    parent[:root_node_id].presence || parent.id
  end
end
