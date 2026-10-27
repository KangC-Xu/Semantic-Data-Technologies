# 英文语料来源 / English language-resource sources

本目录只包含课堂英文分词、停用词和词形还原需要的数据。Notebook 只查找这里的语料，不依赖原电脑目录，也不会在运行时下载。
This folder contains only the resources needed for English tokenization, stop words and lemmatization. The notebook searches this folder exclusively, without depending on the original computer or downloading corpora at runtime.

| 资源 / Resource | 随作业提供的内容 / Bundled content | 官方源 / Official source |
|---|---|---|
| punkt_tab | English 的四个模型表、原 README / Four English model tables and the original README | https://github.com/nltk/nltk_data/tree/gh-pages/packages/tokenizers |
| stopwords | English 文件、原 README / English list and the original README | https://github.com/nltk/nltk_data/tree/gh-pages/packages/corpora |
| WordNet 3.0 | 未修改的 wordnet.zip、可见许可副本 / Unmodified wordnet.zip and a visible license copy | https://github.com/nltk/nltk_data/blob/gh-pages/packages/corpora/wordnet.zip |

WordNet 压缩包保持原样，NLTK 可直接读取，不需要解压。它本身包含原 LICENSE，另保留 `nltk_data/corpora/WORDNET_LICENSE.txt` 供查阅。数据和说明保留上游原始内容及许可，不因仓库的代码许可证而改变。
The WordNet archive is unchanged and NLTK reads it directly without extraction. It contains its original LICENSE; `nltk_data/corpora/WORDNET_LICENSE.txt` is also provided for inspection. Upstream data, notices and license terms remain unchanged and are not replaced by the repository's code license.

WordNet 3.0 Copyright 2006 by Princeton University. All rights reserved. 权利和免责声明见原许可。 / See the original license for permissions and disclaimers.

来源完整性核对：本机官方语料包此前已按 NLTK 官方清单验证 SHA256；本作业中的子集从这些文件逐字节复制。原数据不做换行转换，以保留上游字节。
Source integrity: the official archives were previously checked against the NLTK SHA256 manifest; this subset was copied byte for byte from those resources. Line endings in upstream data are not converted, preserving the original bytes.

| 官方压缩包 / Official archive | SHA256 |
|---|---|
| punkt_tab.zip | e57f64187974277726a3417ca6f181ec5403676c717672eef6a748a7b20e0106 |
| stopwords.zip | 48c0e52d8b52546e827f53761fb30300c0ab94f70660d28bd65ba0a86270946b |
| wordnet.zip | cbda5ea6eef7f36a97a43d4a75f85e07fccbb4f23657d27b4ccbc93e2646ab59 |

仅附英文资源，不含多语言 omw-1.4 和旧 pickle 版 punkt。 / Only English resources are bundled; multilingual omw-1.4 and the older pickle-based punkt models are omitted.
