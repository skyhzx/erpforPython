#!/bin/bash
# Node.js 22 升级测试脚本

set -e  # 遇到错误立即退出

echo "🚀 开始 Node.js 22 升级测试..."
echo ""

# 检查 Node.js 版本
echo "📋 检查当前 Node.js 版本..."
node --version || echo "⚠️  Node.js 未安装"
echo ""

# 清理旧依赖
echo "🧹 清理旧的 node_modules 和 lock 文件..."
rm -rf node_modules
rm -f package-lock.json
echo "✅ 清理完成"
echo ""

# 安装新依赖
echo "📦 安装更新后的依赖..."
npm install
echo "✅ 依赖安装完成"
echo ""

# 运行 lint 检查
echo "🔍 运行 ESLint 检查..."
npm run lint || echo "⚠️  Lint 检查发现问题，请检查"
echo ""

# 尝试构建
echo "🏗️  运行生产构建..."
NODE_OPTIONS="--openssl-legacy-provider" npm run build
echo "✅ 构建成功"
echo ""

echo "🎉 升级测试完成！"
echo ""
echo "📋 下一步："
echo "1. 运行开发服务器测试: npm run serve"
echo "2. 如果有问题，可以回退到备份: cd ../../ERP-Project-backup-node12"
