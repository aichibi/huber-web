-- ============================================
-- Supabase 留言板数据库建表 SQL
-- 在 Supabase SQL Editor 中执行此脚本
-- ============================================

-- 1. 创建 messages 表
CREATE TABLE IF NOT EXISTS messages (
  id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name TEXT DEFAULT '匿名',
  text TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. 开启 Row Level Security
ALTER TABLE messages ENABLE ROW LEVEL SECURITY;

-- 3. 允许任何人读取留言
CREATE POLICY "允许任何人读取" ON messages
  FOR SELECT USING (true);

-- 4. 允许任何人插入留言
CREATE POLICY "允许任何人插入" ON messages
  FOR INSERT WITH CHECK (true);

-- 5. （可选）插入一条测试留言
INSERT INTO messages (name, text) VALUES ('系统', '留言板已就绪，快来抢沙发吧！');
