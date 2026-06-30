


# 🛡️ Local Security Hardening Auditor: Linha de Base e Conformidade

![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?style=flat-square&logo=powershell&logoColor=white)

Este repositório contém um script automatizado de auditoria em PowerShell projetado para avaliar a postura de segurança local (*Security Hardening*) de ativos Windows. Ele foca na identificação de desvios de configuração que violam as boas práticas de governança e frameworks de segurança (como o CIS Benchmarks).

---

## 📋 Cenário e Objetivo

O *Hardening* é o processo de mitigar vulnerabilidades ao desativar funções desnecessárias, garantir que as proteções nativas estejam ligadas e auditar privilégios. 

Este laboratório simula a ação de um analista de **SecOps ou Auditoria de TI**, executando uma varredura rápida na máquina para mapear se os controles básicos de segurança estão em conformidade com a política corporativa.

---

## 🔍 Controles Auditados

O script realiza a leitura de 4 pilares essenciais de segurança do sistema operacional:

1.  **Windows Firewall:** Garante que todos os perfis (Domínio, Privado e Público) estejam habilitados para bloquear conexões não autorizadas.
2.  **Windows Defender:** Valida se a proteção antivírus e antimalware em tempo real está ativa.
3.  **Compartilhamentos de Rede (SMB Shares):** Identifica pastas compartilhadas abertas na rede que poderiam ser usadas por atacantes para movimentação lateral.
4.  **Privilégios Locais (Contas de Admin):** Lista todos os usuários do grupo de administradores, destacando contas que necessitam de revisão sob o princípio do privilégio mínimo.

---

---

## 🎯 Validação Prática e Geração de Logs

Ao ser executado, o script realiza a dupla entrega dos resultados:

1. **Saída Visual no Console:** Exibe o status em tempo real com alertas coloridos para rápida identificação visual do analista.
2. **Geração de Log Estruturado:** Grava apenas os resultados puros em um arquivo físico (`auditoria_hardening.log`), aplicando carimbos de data e hora (*timestamps*) em formato padronizado. Este formato é ideal para ser consumido por ferramentas de monitoramento centralizado ou sistemas SIEM.

### Exemplo do Log de Auditoria Gerado:

```text
=== INÍCIO DO LOG DE AUDITORIA ===
[ 2026-06-30 12:30:15 ] FIREWALL: OK - Todos os perfis estão ativos.
[ 2026-06-30 12:30:16 ] ANTIVIRUS: OK - Proteção em tempo real ativada.
[ 2026-06-30 12:30:16 ] COMPARTILHAMENTO: OK - Nenhum compartilhamento inseguro detectado.
[ 2026-06-30 12:30:17 ] PRIVILEGIOS: PADRAO - Conta administrativa padrão: Máquina-PC\Administrador
[ 2026-06-30 12:30:17 ] PRIVILEGIOS: REVISAR - Usuário 'Máquina-PC\Usuario' possui privilégios de Admin Local.
=== FIM DO LOG DE AUDITORIA ===
```
## 🧠 Conceitos de Cibersegurança Aplicados

*   **Princípio do Privilégio Mínimo (PoLP):** A auditoria contínua de membros do grupo local de administradores impede o privilégio excessivo acumulado (*Privilege Creep*).
*   **Gerenciamento de Superfície de Ataque:** Mapear compartilhamentos SMB expostos mitiga o risco de ataques que utilizam varreduras de rede para roubo de dados.
*   **Continuous Compliance (Conformidade Contínua):** Em um cenário corporativo, scripts como este podem ser orquestrados via GPO (Diretivas de Grupo) ou ferramentas de RMM para auditar milhares de máquinas simultaneamente e alimentar painéis de GRC.
