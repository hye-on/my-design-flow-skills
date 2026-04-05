# Knowledge Base 사용 규칙

## 핵심 원칙

1. **코드가 source of truth**
   - knowledge-base는 코드를 **설명**하는 것이지 **대체**하는 게 아님
   - knowledge-base와 코드가 충돌하면 코드가 맞음

2. **코드가 변하면 knowledge-base도 업데이트**
   - post-edit hook이 자동으로 트리거됨
   - UI 파일 수정 시 → `screen-inventory.md`, `component-graph.md` 확인
   - 디자인 토큰 수정 시 → `visual-language.md`, `token-audit.md` 확인
   - 유저 플로우 변경 시 → `user-flows.md` 확인

3. **새 세션 시작 시 knowledge-base 파일들을 먼저 읽어서 프로젝트 디자인 현황 파악**
   - `screen-inventory.md` → 현재 화면 목록과 상태
   - `component-graph.md` → 컴포넌트 구조와 의존 관계
   - `visual-language.md` → 디자인 토큰 현황
   - `user-flows.md` → 유저 플로우 맵
   - `token-audit.md` → 하드코딩된 값 목록
   - `_sync-log.md` → 최근 변경 이력

4. **SYNC_NEEDED 플래그가 있으면 해당 파일을 먼저 업데이트**
   - 파일 상단에 `<!-- SYNC_NEEDED -->` 주석이 있으면 코드와 동기화가 필요한 상태
   - 다른 작업 전에 해당 파일을 코드 기준으로 업데이트
   - 업데이트 완료 후 `SYNC_NEEDED` 플래그 제거
   - `_sync-log.md`에 업데이트 내역 기록

## 파일 구조

```
knowledge-base/
├── CLAUDE.md                 # (이 파일) knowledge-base 사용 규칙
└── _project-template/        # 프로젝트 초기화 시 복사되는 템플릿
    ├── screen-inventory.md   # 화면 인벤토리
    ├── component-graph.md    # 컴포넌트 그래프
    ├── visual-language.md    # 비주얼 랭귀지 현황
    ├── user-flows.md         # 유저 플로우
    ├── token-audit.md        # 토큰 감사
    └── _sync-log.md          # 동기화 로그
```
