# 🛡️ Script de Auditoria de Conexões e Portas Críticas (PowerShell)

Este subprojeto contém um script automatizado em PowerShell desenvolvido para auxiliar analistas de infraestrutura e operações de segurança (SecOps/Blue Team) na auditoria rápida de conexões de rede ativas em servidores ou estações de trabalho Windows.

O objetivo principal é identificar portas lógicas abertas ou conexões estabelecidas que correspondam a serviços historicamente vulneráveis ou frequentemente visados por agentes maliciosos para vetores de ataque como força bruta, varreduras (scanning) ou movimentação lateral.

---

## 🚀 Funcionalidades do Script

* **Varredura em Tempo Real:** Coleta conexões TCP ativas utilizando o cmdlet nativo `Get-NetTCPConnection` nos estados `Listen` (Ouvindo) e `Established` (Estabelecida).
* **Mapeamento de Ameaças:** Cruza de forma inteligente as portas ativas do sistema com um dicionário de portas de alto risco mapeadas no script.
* **Alertas Visuais:** Exibe alertas em vermelho diretamente no console do PowerShell para triagem imediata do operador caso conexões de risco sejam encontradas.
* **Tratamento de Exceções:** Execução silenciosa (`-ErrorAction SilentlyContinue`) para evitar poluição de tela com erros de permissão de conexões do sistema.

---

## 🛠️ Portas Críticas Monitoradas

O script monitora portas e serviços específicos que demandam atenção em auditorias de segurança de redes e firewalls:

| Porta TCP | Serviço Monitorado | Risco Associado |
| :--- | :--- | :--- |
| **21** | FTP | Protocolo inseguro; tráfego de dados e credenciais em texto claro. |
| **22** | SSH | Alvo constante de ataques de força bruta se exposto para a internet. |
| **23** | Telnet | Protocolo legado e altamente inseguro (sem criptografia). |
| **80** | HTTP | Tráfego web não criptografado; suscetível a interceptação. |
| **139 / 445**| NetBIOS / SMB | Vetores comuns para infecção por Ransomwares e exploits como *EternalBlue*. |
| **3389** | RDP | Acesso remoto via tela; principal alvo de invasões de força bruta. |

---

## 📦 Como Instalar e Executar

### Pré-requisitos
Por padrão, o Windows restringe a execução de scripts `.ps1` que não foram assinados digitalmente. Para rodar o script no seu ambiente de laboratório:

1. Abra o PowerShell como **Administrador**.
2. Altere temporariamente a política de execução para a sessão atual com o comando:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
